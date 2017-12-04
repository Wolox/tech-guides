## ORM (Object Relational Mapping)

**ORM** it's a programming strategy for relating our object-oriented world with the database persistence. It gives us an abstraction by manipulating SQL queries: the ORM has the responsibility to make and execute them. It's important to understand that it is not a magic tool, it simply automates the database management. An important point of this is that as being an automated tool, complex queries can be hard to deal with using an ORM.

In Node we use [Sequelize](http://docs.sequelizejs.com/). The database connection it is managed in [app/orm.js](https://github.com/Wolox/express-js-bootstrap/blob/master/app/orm.js). We create our models in [app/models](https://github.com/Wolox/express-js-bootstrap/tree/master/app/models), and we use them for both our OO world and our persistence model, that's why here we specified the data type for each attribute and any typical constraint like allowNull or primaryKey.

In [app/models/index](https://github.com/Wolox/express-js-bootstrap/blob/master/app/models/index.js) is where we define our [associations](http://docs.sequelizejs.com/manual/tutorial/associations.html) of the persistence model. In the linked documentation you will find how a relationship is mapped adding the foreign keys in the appropriate table.
When we start our application, the ORM will look for existing models and create the ones it does not found. **Be careful**: the ORM won't update any model that changed a name, attribute, constraint, or anything like that. That's why we use **migrations**.   

# Migrations
A migration it's a process that can extract, transform or load data and models into the database. It allows us to keep our data consistent with any changes we introduce to our model, because the ORM does not resolve this problem for us. That's why all the changes we make in our model must have a migration responsible of reflecting the change in the database, like adding or removing attributes, constraints, primary keys, and so on. 

A good practise which we drive in Wolox is to create a migration in the moment we create a model, and not only use them to manage our changes to the initial model. Sequelize gives us the command [model:generate](http://docs.sequelizejs.com/manual/tutorial/migrations.html) which creates a model and generates a migration to reflect the change in the database. It's important to create the migrations files with **migration:generate** because this puts a timestamp to our file, so the migrations can run in the order they are supposed to. For more information about commands, feel free to read the [documentation](https://github.com/sequelize/cli#documentation). 

The migrations in Sequelize have an **Up** method, which will execute when we run the migration, and a **Down** method that has the inverse action to revert the migration effect. 

To run migrations we use the command **npm run migrations**. It's important to know that in development environment the application won't start if any migration is pending to run, but in **production** the migrations will run automatically.

