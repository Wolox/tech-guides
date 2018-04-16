# How to use Spree gem

*Abstract: In this documents, we will present some tricks to deal with spree gem. These tricks will be at nivel database, backoffice, backend, frontend... This will be a good base to start with spree and have a common way to work with this gem.*

## Introduction

Spree is a useful gem for Ruby On Rails, that allow to create an e-commerce in few command and a few configuration. Spree is composite of various gem and it accepts lots of extension gems developed by the community.

##### Spree e-commerce contains:

- Backoffice;
- Responsive front-end;
- An API;
- A way to authenticate with devise;
- A well constructed database to manage orders and users.

##### Different possibilities to use spree:

1. A client wants an e-commerce like shopify with a custom design, it’s possible to use the gem a simply adapt the front-end;
2. A client wants an e-commerce with a complex front-end (or because he wants to design it himself or because design need specific constraints) an approach could be using spree API and a front-end framework;
3. A client wants to a very specific backoffice or an e-commerce with particularity over the scope of usual e-commerce. Spree can not be adapted easily.


***Note**: There is also a fork of spree, SOLIDUS. In some case could be interesting look a it.*

## Some useful links

Before to start, there is a list of useful links from oficial spree documentation, to find extension for spree, to read external tutorial or to see website developed with this gem.

##### Spree official documentation:

- [The gem](https://github.com/spree/spree)
- [For developers](https://guides.spreecommerce.org/developer/)
- [For api](https://guides.spreecommerce.org/api/)
- [Factories for testing](https://github.com/spree/spree/tree/master/core/lib/spree/testing_support/factories)

##### Some useful spree extension:

To manage social auth like Facebook, go [here](https://github.com/spree-contrib/spree_social).

##### Some tutorials:

- [Getting started with spree](https://www.youtube.com/watch?v=IgCVg-GaQ2k)
- [Integrate stripe with spee](https://blog.botreetechnologies.com/integrate-stripe-payment-gateway-in-spree-commerce-71e32239ba27)
- [Adding a custom model in spree database](https://nnodes.com/blog/2016/custom-model-with-spree)
- [Create an extension for spree](https://nebulab.it/blog/developing-spree-extension-with-tdd/)

##### Website developed with spree:

- [Enjoy-vue (stage)](https://enjoy-vue-stage.herokuapp.com/)
- Enjoy-vue GitLab, see Gregoire Marnotte [Gmarn](https://github.com/Gmarn)



## Basic Spree gem

### First step tutorial

On the official documentation of spree there is a perfect tutorial to start, [here](https://guides.spreecommerce.org/developer/getting_started_tutorial.html).

We recommend to install spree gem with the version *3.4* because in this version you can handle frontend view easier.

```ruby
gem 'spree', '~> 3.4'
gem 'spree_auth_devise', '~> 3.3'
gem 'spree_gateway', '~> 3.3'
```

### A word on spree gem composition
Spree is not an unic gem, in reality spree is composed of various gem, and when you bundle spree this gem will be install:

- *spree*: base gem contain only the installer for other gems;
- *spree_core*: this is the base which contains all models and testing support;
- *spree_cmd*: spree command line utility to create extension;
- *spree_api*: api of spree;
- *spree_backend*: handle all the backoffice / admin;
- *spree_frontend*: manage all views and front-end controller;

The two other gems recently install, spree_auth_devise and spree_gateway, allow respectively to handle authentication with devise and user model and manage gateway for payment.

## Some useful extensions

There is to extension gem that we use in Enjoy-Vue:

- spree_social: to manage authentication across facebook, twitter, github...
```ruby
gem 'spree_social', github: 'spree-contrib/spree_social'
```
- spree_mail_settings: to manage mail sending.
```ruby
gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings'
```


## Database / Model tricks
In some cases it could be useful to modify or create table in spree database. Spree allow that with a simple way but some things are good to have in mind.

### Module spree for models

Before to start there is an important fact to know, all model from spree are in the module **Spree**. This implies, when calling a model with the ORM, across the rails console for example, to cast **Spree::** before must be specify before.
For example to have the user with id 8:

```ruby
Spree::Users.find(1)
```

### Generate a migration for an existing model

Here we are going to add some fields to user model from spree.

##### Migration

Here an example of migration on the user model from spree. Four columns are added to the model: **gender**, **first_name**, **last_name** and **birthday**. To generate the migration do as usual with `rails generate migration...`

```ruby
class AddDataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :gender, :string, default: 'other'
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :birthday, :date, default: '2000-01-01'
  end
end
```

The table is in spree module so even if the model name is *User*, **spree_** is required before model name. The rest is define as usual. Version of migration (here 5.1) need to be specify.

##### Model modification

Now, we are going to add some adaptation to the user model from spree. Spree official documentation advice to use decorator to modify his own class. So here we will create a file user_decorator.rb and modify the class with **.class_eval**.


```ruby
#/app/models/spree/user_decorator.rb
Spree::User.class_eval do
  validates :login, presence: true, uniqueness: true

  validates :birthday, timeliness: { on_or_before: -> { Date.current }, type: :date }
  # Here we do not use an integer with enum to avoid the error:
  # You tried to define an enum named "gender" on the model "Spree::User",
  # but this will generate a instance method "female?", which is already defined by another enum.
  validates :gender, inclusion: %w[female male other]

  has_many :prescriptions, class_name: 'Spree::Prescription', dependent: :destroy
end
```

Here nothing strange, we define validates and relation as usual. We will show how define **belongs_to** on the next example. It’s also possible to define method for the model. In need to modificate an existing method from spree gem, it is sufficient to define here a method with the same name and write custom code on it.


### Generate a new model
Here we are going to add a new model prescription which belongs to an user.

##### Migration

In this migration a nex model Prescription is create, but we need to specify spree_ to specify the appartenance to spree module. The definition of the fields is usual. To generate the migration do as usual with rails generate model...

```ruby
class CreateSpreePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_prescriptions do |t|
      t.decimal :add_right, default: 0.0, null: false
      t.decimal :add_left, default: 0.0, null: false
      t.boolean :pupillary_distance_double
      t.string :title, default: '', null: false

      t.belongs_to :user                                                                                                          
      t.timestamps
    end
  end
end
```

The main difference as usual migration, is the **belongs_to**. Normally we use **references**, but with the spree module to avoid some errors, is advised to use **belongs_to**.

##### Model creation

As we specify in *User* model the **has_many**, here we define the **belongs_to** and define the class name to point.

```ruby
#app/models/spree/prescriptions.rb
module Spree
  class Prescription < Spree::Base
    belongs_to :user, class_name: 'Spree::User'

    validates :add_right, :add_left, :title, presence: true
  end
end
```

## Controller tricks

For the controller is the same trick as model:
- to modify an existing controller spree advice to use a *decorator* with **.class_eval** and change the method to custom or add the method you need;
- to add a new controller, link with spree action, just create a class in the spree module (and maybe admin module for backoffice).

There are controllers in every spree gem but they are classified logically:
- *spree_core*: contains mainly helpers for controllers;
- *spree_api*: contains api controllers;
- *spree_backend*: contains admin controller for backoffice;
- *spree_frontend*: contains controllers to handle frontend views;

### Modificate an existing controller

Above we add some parameters to user model and now we want an endpoint to handle the update of the new field. For that nothing more simple that create a decorator and add our endpoint with required method. If the endpoint exist in spree gem this new endpoint will be the only used, else it just a new endpoint.
Here the example code:

```ruby
# /app/controllers/spree/users_controller_decorator.rb
Spree::UsersController.class_eval do
  def update
    params[:user] = add_birthday
    if @user.update_attributes(sanitize_params)
      redirect_to spree.account_url, notice: Spree.t(:account_updated)
    else
      prepare_error
      redirect_to request.env['HTTP_REFERER']
    end
  end

  private

  def sanitize_params
    return params[:user].permit(permitted_params)
  end

  def prepare_error
    error = @user.errors.full_messages.join(', ')
    flash[:error] = error
  end

  def permitted_params
    %i[email login last_name first_name gender birthday]
  end

  def add_birthday
    params[:user].merge(birthday: "#{params[:year]}-#{params[:month]}-#{params[:day]}")
  end
end
```

### Add a new controller

This is a way to add new controller class in spree, nothing magical:

```ruby
#/app/controllers/spree/prescirptions_controller.rb
module Spree
  class PrescriptionsController < Spree::StoreController
    def index
      # Controller logic
    end
  end
end
```

To add an entire part to spree it should be interesting to add a local controller and each new controller class will inherit of it, this class mother should inherit of Spree::StoreController. For example in the case above we will have:

```ruby
  class PrescriptionsController < LocalSpreeController
```

For the routing spree mount **Spree::Core::Engine** to `‘/’`, so every new route in relation with spree gem should be mount here also. In our example we will have:

```ruby
#/config/routes.rb
Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.add_routes do
    resources :prescriptions, only: [:index]
  end
end
```

The rest is equal.

## Frontend tricks

For the frontend there is 3 ways to modify it:

1. You can use bootstrap, example [here](https://github.com/spree/spree/tree/master/frontend) and [here](https://github.com/twbs/bootstrap-sass/blob/master/assets/stylesheets/bootstrap/_variables.scss)

2. The second option is to use deface, which permit to modify native view from spree, this solution is not a good way if the e-commerce need specific views with a design different from spree. At this [link](https://guides.spreecommerce.org/developer/deface_overrides_tutorial.html) you have a complete tutorial to learn more about it.

3. The third option is - modify the HTML and add your CSS - by importing the view into your app and spree will use this views and not the native ones. For that spree *v3.4* allow to import all frontend in one command. This is a good solution for a simple design that do not need javascript action for animation or action and a flow that respect general spree flow. It is this solucion we used for Enjoy Vue and we will developed it.

4. The fourth solution to used only the API and backoffice of Spree and use a frontend framework for views. This solution was never try but seem a good option for design far away from spree general structure. [Some developer ever done it](https://stackoverflow.com/questions/31332651/how-do-i-uninstall-spree-frontend).

### Customize views by template replacement

Here, some tips to handle frontend customization:

##### Import all frontend views locally

With spree *3.4*, it is possible to import locally all frontend views in one command:

```bash
rails generate spree:frontend:copy_views
```

After running this command all view will be in /app/views/spree/ and these views will be rendering. To return to the original view delete the one locally and spree will render its own.

##### Where put CSS and Javascript

CSS for your spree view and javascript must been puts in (the same for backend views):
- */vendor/assets/**javascript**/spree/frontend/*
- */vendor/assets/**stylesheets**/spree/frontend/*

However, images and fonts could be put in /app/assets/.

##### Use slim

All views from spree are in ERB, but use [SLIM](https://github.com/slim-template/slim). It is easier and more readable.


## Backoffice tricks (frontend)

***Note**: if you are looking for information on how to use backoffice you will not find anything here, but you can find all you need [here](https://guides.spreecommerce.org/user/).*

After adding some model to spree, normally the admin should be able to manage it from spree backoffice.
*Controllers*: to add or modify controllers is the same as other controllers use a **decorator** or a new class in **Spree** module which contains **Admin** module.
*Views*: the logic is the same as classic frontend view, use the folder */app/views/spree/admin* and import view you want to modify or add your own.
*Warning*: backoffice is not build with flex, as other frontend views, so to keep coherence do not use flex and try to reuse existing CSS class from spree.

