# Wolox RSpec Style Guide

## Table of Contents

  1. [Blocks](#blocks)
  1. [Context](#context)
  1. [Describe](#describe)
  1. [Descriptions](#descriptions)
  1. [Factories](#factories)
  1. [Folders](#folders)
  1. [Helpers](#helpers)
  1. [It](#it)
  1. [Let](#let)
  1. [Spaces](#spaces)
  1. [Subject](#subject)

## Blocks

- Use `{}` only when defining `let` or `subject` if fits in one line. For everything else use `do; end` instead of `{}`. This is because combining both styles in examples can be confusing when reading the code.

  ```ruby
  # bad
  it {}

  # good
  it do
  end
  ```

## Context

- Using contexts to separate different cases makes your tests easier to read and follow, use them.

- Contexts define a particular scenario in which the program is running, so the description should always start with `when` or `with`.

  ```ruby
  # bad
  context 'if the user sends a query parameter' do
  end

  # good
  context 'with query parameter' do
  end
  ```

## Describe

- Don't use RSpec prefix

  ```ruby
  # bad
  RSpec.describe SomeClass do
  end

  # good
  describe SomeClass do
  end
  ```

## Descriptions

- The descriptions should be short and concise, it should be under 40 characters.

  ```ruby
  # bad
  context 'when the logged user did not send a parameter that is mandatory for the model' do
  end

  # good
  context 'when mandatory parameter is missing' do
  end
  ```

- Use `.` or `::` when defining class methods and `#` when describing instance methods.

  ```ruby
  describe '.class_method' do
  end

  describe '#instance_method' do
  end
  ```

## Factories

- Always use factories or, in case you have a service object that creates your object, use that service object.

  ```ruby
  # bad
  User.create(email: 'some@email.com')

  # good
  create(:user)
  ```

- In your configuration include FactoryGirl::Syntax::Methods so you don't need the prefix everytime.

## Folders

- Always use `rspec-rails` folder conventions for tests. Put your controllers tests in `spec/controllers`, your model tests in `spec/models`, and so on. This way you don't need to specify the type of your test.

  ```ruby
  # bad
  describe SomeController type: :controller do
  end

  # good
  # spec/controllers/some_controller_spec.rb
  describe SomeController do
  end
  ```

## Helpers

- Always define helpers in a file under `spec/support` and require them in `spec_helper.rb` or in `rails_helper.rb` if needed.

  ```ruby
  # bad
  describe SomeController do
  end

  def response_body(response)
    ActiveSupport::JSON.decode(response.body) if response.present?
  end

  # good
  # spec/support/parse_response_header.rb
  module Response
    module JSONParser
      def response_body
        ActiveSupport::JSON.decode(response.body) if response.present?
      end
    end
  end
  ```

## It

- Don't use words like `should` in the example description.

  ```ruby
  # bad
  it 'should find something' do
  end

  # good
  it 'finds something' do
  end
  ```

## Let

- Always insert a new line after defining the lets of your tests.

  ```ruby
  # bad
  let(:something)
  it 'does what we need' do
  end

  # good
  let(:something)

  it 'does what we need' do
  end
  ```

## Spaces

- Always insert a new line between different `it`, `context`, `describe`, etc.

  ```ruby
  # bad
  context 'when something happened' do
    it 'does what we need' do
    end
    it 'does another thing we need' do
    end
  end
  context 'when some other thing happened' do
    it 'does what we need' do
    end
    it 'does another thing we need' do
    end
  end

  # good
  context 'when something happened' do
    it 'does what we need' do
    end

    it 'does another thing we need' do
    end
  end

  context 'when some other thing happened' do
    it 'does what we need' do
    end

    it 'does another thing we need' do
    end
  end
  ```

## Subject

- Use `described_class` when referring to the class that is being tested.

  ```ruby
  # bad
  describe MyClass do
    it 'does what we need' do
      expect(MyClass.some_method).to eq('something')
    end
  end

  # good
  describe MyClass do
    it 'does what we need' do
      expect(described_class.some_method).to eq('something')
    end
  end
  ```

- Use `subject` when you are trying to create an instance of the described class. Do this using `described_class`, and also give it a descriptive name, because you should use it.

  ```ruby
  describe SomeClass do
    describe '#some_method' do
      it 'does what we want' do
        # bad
        expect(described_class.new.to_s).to eq('something')
      end

      it 'does what we want' do
        # also bad
        expect(SomeClass.new.to_s).to eq('something')
      end
    end
  end

  # good
  describe SomeClass do
    subject(:some_class) { SomeClass.new }

    describe '#some_method' do
      it 'does what we want' do
        expect(some_class.to_s).to eq('something')
      end
    end
  end

  ```

## About ##

This project is maintained by [Alejandro Bezdjian](https://github.com/alebian) and it was written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## License

(The MIT License)

Copyright (c) 2017 Alejandro Bezdjian, aka alebian

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
