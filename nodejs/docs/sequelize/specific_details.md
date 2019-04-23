# Sequelize specific details

## Validations in bulk methods

Suppose you have a User model in Sequelize and you have a validation inside.

```javascript
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    'user',
    {
      id: { type: DataTypes.INTEGER, allowNull: false, autoIncrement: true, primaryKey: true },
      userName: { type: DataTypes.STRING, allowNull: false },
      userType: { type: DataTypes.STRING, allowNull: false, validate: { isIn: [['regular', 'administrator']] }
    },
    {}
  );

  User.associate = function(models) {};

  return User;
};
```

If you create an user in the "normal" way and you do not respect the validation, an error will be thrown.
For example:

```javascript
return User.create(
  {
    userName: 'wolox',
    userType: 'notAValidOne'
  }
);
```

But if you handle users with a `bulk` method, such as `bulkCreate`, `bulkUpdate`, or another one, the validation `won't trigger` by default.

```javascript
return User.bulkCreate([
  {
    userName: 'wolox1',
    userType: 'notAValidOne'
  },
  {
    userName: 'wolox2',
    userType: 'notAValidOne'
  }  
]);
```

This will be fine and your instances will be created successfully.
In order to tell Sequelize to trigger the validations in bulk methods, you have to indicate the property `validate` in `true`.

```javascript
return User.bulkCreate([
  {
    userName: 'wolox1',
    userType: 'notAValidOne'
  },
  {
    userName: 'wolox2',
    userType: 'notAValidOne'
  }  
], { validate: true });
```

Now an error will be thrown and our model is secure!
