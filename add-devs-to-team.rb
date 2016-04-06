require 'octokit'

access_token = ARGV[0]
client = Octokit::Client.new(access_token: access_token)
client.auto_paginate = true

teams = client.organization_teams("Wolox")
team = teams.select { |t| t["slug"] == "tech-guide-devs" }.first
team_members_id = Set.new(client.team_members(team["id"]).map { |member| member["id"] })

client.organization_members("Wolox").each do |user|
  next if team_members_id.include?(user["id"])
  puts "Adding user #{user['login']} to team ..."
  client.add_team_member(team["id"], user["login"])
end
