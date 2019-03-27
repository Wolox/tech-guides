# HOW TO use aggregation functions and join clause in Sequelize

## Introduction

Suppose you have two models in Sequelize: One of them is about expense groups, with an ID and name; meanwhile the other, deals with expenses, storing a value and an association with a group of expenses.

Then, the expense groups model should look something like this:

```javascript
module.exports = (sequelize, DataTypes) => {
 const ExpenseGroups = sequelize.define(
   'expenseGroups',
   {
     id: { type: DataTypes.INTEGER, allowNull: false, autoIncrement: true, primaryKey: true },
     name: { type: DataTypes.STRING, allowNull: false }
   },
   {
     underscored: true,
     tableName: 'expense_groups'
   }
 );

 ExpenseGroups.associate = models => {
   ExpenseGroups.hasMany(models.expenses, { foreignKey: 'groupId' });
 };

 return ExpenseGroups;
};
```



And the expenses model can be this:

```javascript
module.exports = (sequelize, DataTypes) => {
 const Expenses = sequelize.define(
   'expenses',
   {
     groupId: { type: DataTypes.INTEGER, field: 'group_id', allowNull: false },
     value: { type: DataTypes.DOUBLE, allowNull: false }
   },
   {
     underscored: true,
     freezeTableName: true
   }
 );

 Expenses.associate = models => {
   Expenses.belongsTo(models.expenseGroups, {
     foreignKey: 'groupId'
   });
 };

 return Expenses;
};
```

Now suppose you have the next data: 

#### Expenses Table
 
| group_id | value |
|:--------:|:-----:|
|1|10|
|1|10|
|1|10|
|2|20|


And you are expecting to obtain the total value of each group. But, how to achieve this?

## Aggregation functions

An aggregation function allow you to perform a calculation given a set of values. This values must be grouped by a common attribute using the  GROUP BY  statement.

From our early problem,  a common SQL query you can use to accomplish this, can be:

```sql
SELECT sum(value) as total FROM expenses GROUP BY group_id;
```

To make this, first you need to import `Sequelize` and use the function `fn`. This function request two parameters: the first is the name of the aggregate function and the second the name of which column will be affected (but this column has to be called with the col function). Bring in this together, the Sequelize query should look like this:

```javascript
const Sequelize = require(‘sequelize’);

exports.getExpenses = () => 
 Expenses.findAll({
   attributes: [[Sequelize.fn('sum', Sequelize.col('value'))], 'total', 'group_id'],
   group: ['group_id']
 });
```


This will generate the next result:

```js
[ 
 { total: 30, group_id: 1 },
 { total: 10, group_id: 2 }
]
```

After understanding the aggregation functions, let’s learn about the join clause

## Aggregation functions and the Join Clause

Sometimes when you have the foreign key and you need another attributes contained in the associated model, you can use the Join clause. In Sequelize, this is a easy task. Just add to the options of the query function, the include key. This will expect an array of objects specifying the model options. But, in our case, because the object will only specify the model key, we can pass the model object instead.

```javascript
const Sequelize = require('sequelize');

exports.getExpenses = () => 
 Expenses.findAll({
   attributes: [[Sequelize.fn('sum', Sequelize.col('value')), 'total']],
   group: ['group_id'],
   include: [Groups]
});
```

**Hold on!** If you run this code, this will throw the next error

> SequelizeDatabaseError: column "expenseGroups.id" must appear in the GROUP BY clause or be used in an aggregate function

This is caused because when we use the include key, Sequelize try to select all the fields of the associated model. To solve this, just group by a common attribute between expenses and groups. In our case, is the `id`. Try putting in the group key, `expenseGroup.id`

```javascript
const expenseGroups = require('../../models').expenseGroups,
 Expenses = require('../../models').expenses,
 Sequelize = require('sequelize');


exports.getExpenses = () => 
 Expenses.findAll({
  attributes: [[Sequelize.fn('sum', Sequelize.col('value')), 'total'], 'group_id'],
  group: ['group_id', 'expenseGroup.id'],
  include: [Groups]
});
```

This will generate the total value of each group and information about the group. So, it will look like this: 

```js
[
    {
        "total": 30,
        "group_id": 1,
        "expenseGroup": {
            "id": 1,
            "name": "Group 1",
            "createdAt": "2019-03-20T03:11:46.679Z",
            "updatedAt": "2019-03-20T03:11:46.679Z"
        }
    },
    {
        "total": 10,
        "group_id": 2,
        "expenseGroup": {
            "id": 2,
            "name": "Group 2",
            "createdAt": "2019-03-20T03:33:18.178Z",
            "updatedAt": "2019-03-20T03:33:18.178Z"
        }
    }
]
```

And that’s all. Now you can use aggregation functions and include models. If you want, you can clean this data to return only the group name and nothing else. To do this, delete `group_id` in attributes, also in the group key because it not be necessary since `expenseGroups.id` is enough; finally, specify in the model clause that you need just the name. For it, pass into the array an object with key model and as value the model Group. Then, as before, set the attributes key and specify just the name. It will look like this:

```javascript
exports.getExpenses = () =>
Expenses.findAll({
  attributes: [[Sequelize.fn('sum', Sequelize.col('value')), 'total']],
  group: ['expenseGroup.id'],
  include: [{
    model: Groups,
    attributes: ['name']
  }]
});
```

And it will return this:
```js
[
    {
        "total": 10,
        "expenseGroup": {
            "name": "Group 2"
        }
    },
    {
        "total": 30,
        "expenseGroup": {
            "name": "Group 1"
        }
    }
]
```

## BONUS: Nested include

Let’s to something a little more *complex*. At the moment, we have two models, `expenses` and `expenseGroups`. An expense store the id from an expense group and a value and we are groupying these groups to obtain the total. Now suppose we add a model between, `expenseSubgroups`.

```javascript
module.exports = (sequelize, DataTypes) => {
 const Subgroups = sequelize.define(
   'expenseSubgroups',
   {
     id: { type: DataTypes.INTEGER, allowNull: false, autoIncrement: true, primaryKey: true },
     groupId: { type: DataTypes.INTEGER, field: 'group_id', allowNull: false },
     name: { type: DataTypes.STRING, allowNull: false }
   },
   {
     underscored: true,
     tableName: 'expense_subgroups'
   }
 );
 Subgroups.associate = models => {
   Subgroups.belongsTo(models.expenseGroups, { foreignKey: 'groupId' });
 };
 return Subgroups;
};

```

Now, an expense will store the id from an expense subgroup, and this will store the id from an expense group. Based on this, we can group by subgroup id. But, how can we still obtaining the group name and now, the subgroup name?

Suppose this data: 

#### Expenses Table
 
| subgroup_id | value |
|:--------:|:-----:|
|1|10|
|1|10|
|1|10|
|2|10|
|3|10|
|3|10|

#### Expense Subgroups Table

| subgroup_id | group_id |
|:--------:|:-----:|
|1|1|
|2|1|
|3|2|

As before, if we want to obtain the total value from each subgroup, we just add into the include array the subgroup model, and into the group key, `expenseSubgroup.id`. At this point, we are only obtaining the subgroup name. To obtain the group name, we need to add in the include key inside the subgroup include and specify by the attributes key that we only want the name. The code isn’t complete yet. If we run the code now, it will throw an error because the generated query will try to obtain the group name, but the group model is not specified in the group by clause. To add this into the group by, maybe you are expecting to add something like this `expenseSubgroup.expenseGroup.id`, but now, because is a nested include, we need to use the `->` arrow expresion. Now, add to the group clause `expenseSubgroup->expenseGroup.id`.

The complete code will be something like this:

```javascript
exports.getExpenses = () =>
Expenses.findAll({
  attributes: [[Sequelize.fn('sum', Sequelize.col('value')), 'total']],
  group: ['expenseSubgroup.id', 'expenseSubgroup->expenseGroup.id'],
  include: [{
    model: Subgroups,
    attributes: ['name'],
    include: [{
      model: Groups,
      attributes: ['name']
    }]
  }]
});
```

And it will return this:

```js
[
    {
        "total": 30,
        "expenseSubgroup": {
            "name": "Group 1 Subgroup 1",
            "expenseGroup": {
                "name": "Group 1"
            }
        }
    },
    {
        "total": 20,
        "expenseSubgroup": {
            "name": "Group 2 Subgroup 1",
            "expenseGroup": {
                "name": "Group 2"
            }
        }
    },
    {
        "total": 10,
        "expenseSubgroup": {
            "name": "Group 1 Subgroup 2",
            "expenseGroup": {
                "name": "Group 1"
            }
        }
    }
]
```

_Made with passion :fire: by @Darvand_

Last update `March 25, 2019`
