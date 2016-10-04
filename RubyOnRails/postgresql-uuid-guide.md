This is a guide to setup your Rails with PostgreSQL app to support uuid fields. This guide has been tested on Rails 5.0

PostgreSQL has a native ```uuid``` field type.

To enable PostgreSQL to generate uuids you need to first add the following migration:

```ruby
class EnableUuidOsspExtension < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
  end
end
```

Then, each table creation should have the following format:

```ruby
class CreateSomeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :some_tables, id: :uuid do |t|
      # (... table's fields ...)
    end
  end
end
```

Guide written by [Enanodr](https://github.com/Enanodr).
