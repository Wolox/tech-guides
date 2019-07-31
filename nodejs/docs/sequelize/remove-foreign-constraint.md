# Do you need to remove a foreign constraint and you don't know the name? How and TIP

## Introduction

To remove a constraint in a Sequelize migration, you can use the `removeConstraint` function, that receive two parameters, the table name and the constraint name. But what happen when you don't know the constraint name? For example, when Sequelize names it differently in each environment. Let's resolve this.

## Why does this happen?

In a migration file, when you want to create a relation between two tables with a foreign key, you probably use the next code

```javascript
queryInterface.addColumn(tableName, field, {
    allowNull: true,
    type: Sequelize.INTEGER,
    references: {
        model: relatedTableName,
        key: relatedField
    }
})
```
When Sequelize runs this migration, it will create a relation with a foreign key. At this moment, everything is ok. But, when you find the foreign constraint name is something like this: `FK__business___busin__467D75B8`. If you see, the final section, is like a random string. So, when you run the same migration in a different environment, the name will be different. So, you can't use `removeConstraint` dynamically.

## How to solve it

1. Find a query that return the name of the foreign constraints of a table on your specific dialect.
For example, in SQL Server, this is the query:

```sql
SELECT OBJECT_NAME(OBJECT_ID) AS constraintName
FROM sys.objects 
WHERE type_desc = 'FOREIGN_KEY_CONSTRAINT'
and OBJECT_NAME(parent_object_id) = tableName
```

Executing this query, it will return for example:
| constraintName |
|:--------:|
|FK__pending_d__sap_r__4C62CE45|
|FK__pending_d__docum__4E4B16B7|

If you have another dialect and you find how to list the foreign constraints, include it in this doc!

2. Now that we have the query, pass that to the `query` function from sequelize. I mean this: `queryInterface.sequelize.query`
This will return something like this

```javascript
[ [ { constraintName: 'FK__pending_d__sap_r__1D72D532' },
    { constraintName: 'FK__pending_d__docum__1E66F96B' } ],
  [ { constraintName: 'FK__pending_d__sap_r__1D72D532' },
    { constraintName: 'FK__pending_d__docum__1E66F96B' } ] ]
```
As you see, it returns and array of arrays. We need to access any array to obtain the names.

3. Combining everything, our code will look like this

```javascript
module.exports = {
  up: (queryInterface, Sequelize) =>
    queryInterface.sequelize
      .query(selectAllFKConstraintsName)
      .then(constraints =>
        Promise.all(
          constraints
            .shift()
            .map(({ constraintName }) => queryInterface.removeConstraint(tableName, constraintName))
        )
      ),
  down: (queryInterface, Sequelize) => ...
}
```
Then, you can add your new foreign relation.

## TIP

The next time you need to create a foreign key, use the `addConstraint` function to know the constraint name

```javascript
queryInterface.addConstraint(tableName, fields, {
          type: 'foreign key',
          name: fkConstraintName,
          references: {
            table
            field
          }
        })
```

_Made with passion :fire: by @Darvand_

Last update `June 20, 2019`