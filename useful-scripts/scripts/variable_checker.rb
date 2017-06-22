require 'pathname'
require 'json'

################################################################################
# USAGE:                                                                       #
#   Execute this script from console like                                      #
#     $> ruby variable_checker.rb ./repositories_to_check_example.json         #
#                                                                              #
#   Create your own repositories.json file following the example               #
################################################################################

REPOSITORIES_JSON_PATH = ARGV[0]
REPO_PATHS = JSON.parse(File.read(REPOSITORIES_JSON_PATH))

# IGNORE THIS
# Monkey patch String for colors
# IGNORE THIS
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end
end
# IGNORE THIS
# IGNORE THIS
# IGNORE THIS


class AwsVariableChecker
  attr_reader :eb_instance, :tech

  def initialize(app_path, eb_instance, tech)
    @app_path = Pathname.new(app_path)
    raise ArgumentError unless @app_path.directory?
    @eb_instance = eb_instance
    @tech = tech
  end

  def find_missing_variables_in_eb
    array_difference(secret_variables, eb_variables)
  end

  def find_missing_variables_in_secrets
    array_difference(eb_variables, secret_variables)
  end

  private

  def secret_variables
    case tech
    when 'rails'
      @secret_variables ||= parse_secrets_rails
    when 'node'
      @secret_variables ||= parse_secrets_node
    end
  end

  def eb_variables
    @eb_variables ||= parse_eb_variables
  end

  def parse_secrets_rails
    secrets_path = @app_path + 'config/secrets.yml'
    secrets = []
    File.open(secrets_path, 'r') do |f|
      f.each_line do |line|
        env = line[/<%=(.*?)%>/m, 1].gsub(' ', '') unless line[/<%=(.*?)%>/m, 1].nil?
        next if env.nil?
        variable = env[/ENV\["(.*?)"\]/m, 1]
        secrets << variable unless variable.empty?
      end
    end
    secrets.uniq
  end

  def parse_secrets_node
    secrets_path = @app_path + 'config/production.js'
    secrets = []
    File.open(secrets_path, 'r') do |f|
      f.each_line do |line|
        next unless line.include? 'process.env'
        var = line[/.*process.env.(\w*)/, 1]
        secrets << var
      end
    end
    secrets.uniq
  end

  def parse_eb_variables
    variables = `cd #{@app_path} && eb printenv #{eb_instance}`.split("\n")
    variables[1..-1].map { |variable| variable[5..-1].split(' = ').first }
  end

  def array_difference(arr1, arr2)
    missing = []
    arr1.each do |element|
      missing << element unless arr2.include?(element)
    end
    missing
  end
end


# From the data, we create one checker for each eb instance
CHECKERS = REPO_PATHS.each_with_object({}) do |repo, hash|
  checkers = []
  repo['instances'].each do |instance|
    begin
      checkers << AwsVariableChecker.new(repo['path'], instance, repo['tech'])
    rescue
      puts "Wrong repository path for #{repo['name']}".red
      exit
    end
  end
  hash[repo['name']] = checkers
end

# Now we check the missing variables
CHECKERS.each do |api_name, checkers|
  puts "################################################################################".blue
  puts "              Checking ENV variables for #{api_name}".blue
  puts "################################################################################".blue
  checkers.each do |checker|
    missing_variables = checker.find_missing_variables_in_eb
    if missing_variables.empty?
      puts "[+] No missing variables in #{checker.eb_instance}".green
    else
      puts "[-] Missing variables in #{checker.eb_instance}:".red
      puts missing_variables
      puts ''
    end
  end
end
