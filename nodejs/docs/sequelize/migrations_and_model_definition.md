# Model definition

The models in Sequelize can be defined functionally or by classes, but we usually use the functional form.

### The `define(model, attributes, [options])` method

To define mappings between a model and a table, use the `define` method. In this case Sequelize will then automatically add the attributes createdAt and updatedAt to it to have control of inserts or updates (you can avoid this attributes with the `timestamps` option in the definition).
For example:

```javascript
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    'users',
    {
      mail: { type: DataTypes.STRING },
      fullName: { type: DataTypes.STRING },
      phone: { type: DataTypes.STRING }
    },
    {
      timestamps: false
    }
  );
  return User;
};
```

Here we are defining a constant called `User` (note that this name is in PascalCase because it is a model) and his value is the result of `sequelize.define` method. After this definition, the function return the User model.

### Options of `define` method

[Here](https://sequelize.readthedocs.io/en/2.0/docs/models-definition/#configuration) you can see the options for the third parameter of `define` method

# Migrations

### How yo create a migration

To create a migration we can use the following command on your project roots:

`./node_modules/.bin/sequelize migration:create --name="name-of-migration" --config ./migrations/config.js --migrations-path ./migrations/migrations`

Note that the migration was created in your `migrations` folder. If checks it, you will see a code like this in the new migration:

```javascript
'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    /*
      Add altering commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.createTable('users', { id: Sequelize.INTEGER });
    */
  },

  down: (queryInterface, Sequelize) => {
    /*
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.dropTable('users');
    */
  }
};
```

We implements an `up` function to run `migration` and down function to undo migration (whenever possible).
The params that functions receive are `queryInterface` and `Sequelize`. The first has functions to modify your current schema, for example: `createTable`, `addColumn`, `changeColumn`, `removeColumn`, `addIndex`, `removeIndex`, `addConstraint`, `removeConstraint`, `bulkInsert`, `bulkUpdate`, `bulkDelete` (you can see all functions [here](https://sequelize.org/master/class/lib/query-interface.js~QueryInterface.html)). The second parameter, we used for different's types data (for example `INTEGER` or `STRING`).

### How works migrations

When we run migrations for the first time, a new table called `SequelizeMeta` is created. This table will save the names of the migrations executed to keep track of them, when a migration is successful name of file would be stored here (check [umzug](https://github.com/sequelize/umzug) for more detail).
On app start we have some scenarios:

- Some migrations are pending:
  - In `development` mode: app not start, migrations should be manually executed with npm run migrations command.
  - In `production` mode: migrations runs automatically, if anything fails we have to check manually.
- Migrations are up-to-date: nothing to do in any environment, app start automatically.

# Operators

We often use operators in our queries. For this, Sequelize makes available the `Op` object that can be called as follows:

```javascript
const { Op } = require('sequelize');
```

[Here](https://sequelize.org/master/manual/querying.html#operators) you can see all operators.

### How to use operators

In this section you will find some examples

1. Search for updated users in the last two hours

```javascript
User.findAll({
  where: {
    [Op.and]: { updatedAt: { [Op.gte]: moment().subtract(2, 'hours'), [Op.lte]: moment() } }
  }
});
```

Output query: `SELECT 'id', 'mail', 'fullName', 'phone' FROM 'users' AS 'users' WHERE (('users'.'updatedAt' >= '2019-09-27 14:07:50' AND 'users'.'updatedAt' <= '2019-09-27 16:07:50'));`

2. Search for users that have `fullName` in `null` or mail contains `@wolox.com.ar`

```javascript
User.findAll({
  where: {
    [Op.or]: {
      fullName: { [Op.is]: null },
      mail: { [Op.like]: '@wolox.com.ar' }
    }
  }
});
```

Output query: `SELECT 'id', 'mail', 'fullName', 'phone' FROM 'users' AS 'users' WHERE ('users'.'fullName' IS NULL OR 'users'.'mail' LIKE '%@wolox.com.ar');`
