# Sequelize specific details

## Validations in bulk methods

Let's suppose you have an User model in Sequelize with a validation inside it.
```javascript
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define(
    'user',
    {
      id: { type: DataTypes.INTEGER, allowNull: false, autoIncrement: true, primaryKey: true },
      userName: { type: DataTypes.STRING, allowNull: false },
      userType: { 
        type: DataTypes.STRING,
        allowNull: false,
        validate: { isIn: [['regular', 'administrator']] }
    },
    {}
  );

  User.associate = function(models) {};

  return User;
};
```

If you create an user in the "normal" way and you do not respect the validation, an error will be thrown.
For example, the following code will throw an error:
```javascript
return User.create(
  {
    userName: 'wolox',
    userType: 'notAValidOne'
  }
);
```

But if you handle users with a `bulk` method, such as `bulkCreate`, `bulkUpdate`, or another one, the validation `won't be triggered` by default.
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

Although there are invalid values, the instances are created successfully, due the behavior of bulk actions in Sequelize.
In order to tell Sequelize to trigger the validations in bulk methods, you have to set the property `validate` to `true`.
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

Now, since validations are enabled, an error will be thrown and our model is secure!

Source: http://docs.sequelizejs.com/class/lib/model.js~Model.html#static-method-bulkCreate
