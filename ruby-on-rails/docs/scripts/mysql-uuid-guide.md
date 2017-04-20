This is a guide to setup Rails with MySQL app to support uuid fields. This guide has been tested on Rails 5.0

MySQL doesn't have a native ```uuid``` field type. We need to use string type
and manually generate it.

Then, each table creation should have the following format:

```ruby
class CreateSomeModel < ActiveRecord::Migration[5.0]
  def change
    create_table :some_models, id: false do |t|
      t.string :id,               null: false, limit: 36
      ( ... the rest of the values ... )
    end
    execute "ALTER TABLE some_models ADD PRIMARY KEY (id);"
  end
end
```

Each model that is wished to have a uuid as primary key should include the following module:
```ruby
module UuidGenerator
  def self.included(base)
    base.primary_key = 'id'
    base.before_create :assign_uuid
  end

  protected

  def assign_uuid
    uuid_candidate = ''
    loop do
      uuid_candidate = SecureRandom.uuid.upcase
      break unless self.class.find_by(id: uuid_candidate).present?
    end
    self.id = uuid_candidate
  end
end
```

And then the module should be included like the following:
```ruby
class SomeModel < ApplicationRecord
  include UuidGenerator
  # some mode code
end
```

You can add the module to the `ApplicationRecord` added in Rails 5, if you want the uuid in all your `Active Record` models:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include UuidGenerator
end
```

Guide written by [Enanodr](https://github.com/Enanodr).
