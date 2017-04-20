# MercadoPago

This implementation intends to be an interface between your application and the MercadoPago gem, things implemented:

- Let users pay to your site directly.
- Let users pay to other users (marketplace).
- Receive notifications.
- Syncronization with a user account.

## Usage

### Setup

#### Creating the MercadoPago application

Once logged in with your MercadoPago account, go to https://applications.mercadopago.com.ar and create 
a MercadoPago application.
If you want to interact with the MercadoPago on behalf of third party users then you must check the
**MP Connect / Marketplace mode** box.

Once created, you can access the **App ID** and the **Secret Key**. You will need this later.

#### Installing Rails gems
First it is required to add the official gem to the gemfile:
```ruby
gem 'mercadopago-sdk', '~> 0.3.4'
```

### Models involved

#### Payable

You must include the Payable module to the models that represents a concept that users should pay
for. Also you must add some fields to that models.

>##### mp_preference_id
>The ID associated to a Checkout Preference.
>
>##### mp_init_point
>The URL where users begin the payment process.

The ActiveRecord migration should be something like:

```ruby
class ChangePayable < ActiveRecord::Migration
  def change
    change_table :reservations do |t|
      t.string :mp_preference_id
      t.string :mp_init_point
    end
  end
end
```

The model must implement the ```mp_preference_items``` method and return an array of items with 
the following structure:
```ruby
[
  {
    title: 'Microphone',
    quantity: 3,
    unit_price: 15.24,
    currency_id: 'ARS'
  }
]
```

Optionally, the model can implement the ```seller``` method for selling on behalf of a third party
user (marketplace)

#### MercadopagoPayment

Represents a payment issued by a MercadoPago user with a Checkout Preference created by the 
application.


>##### mp_payment_id
>The ID associated to a MercadoPago Payment.

>##### mp_transaction_amount
>The amount of money involved in the payment

>##### mp_status
>One of ['approved', 'pending', 'rejected', 'in_process', 'in_mediation', 'cancelled', 'refunded', 'charged_back']
>See more at: https://www.mercadopago.com.ar/developers/en/api-docs/basic-checkout/ipn/payment-status/

>##### payable_id
>The ID associated with the Payable object associated with the payment

>##### payable_type
>The name of the class of the Payable object associated with the payment

The ActiveRecord migration should be something like:

```ruby
class CreateMercadopagoPayment < ActiveRecord::Migration
  def change
    create_table :mercadopago_payments do |t|
      t.string :mp_payment_id
      t.string :mp_transaction_amount
      t.string :mp_status
      t.references :payable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
```

#### Marketplace User (Optional)
If you want to act on behalf of third party users, then you must get the necessary credentials and
store them with your User model.

The fields required for this are:

>##### mp_authorization_code
>The code used to obtain the access token for the first time
>##### mp_access_token
>This token is used on every request issued to the MercadoPago API
>##### mp_refresh_token
>This token is used when the access token expires to obtain a new access token
>##### mp_user_id
>The MercadoPago user ID
>##### mp_expires_in
>The lapse of time for which the access_token is valid
>##### mp_public_key
> The MercadoPago user public key

```ruby
class AddMercadoPagoFieldsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :mp_authorization_code
      t.string :mp_access_token
      t.string :mp_refresh_token
      t.string :mp_user_id
      t.string :mp_expires_in
      t.string :mp_public_key
    end
  end
end
```

### Third party users connection (marketplace)


1. Redirect the user to the authorization url. The user will be requested to accept some permissions
and then will be redirected back to your application to the URL configured in the config file.

  ```ruby
    Mercadopago::Connect.new.authorization_url
  ```

2. Once the user came back, you will get an authorization code by parameter. Use that code to obtain
the user credentials and store those credentials

  ```ruby
    Mercadopago::Connect.new.update_seller_credentials(current_user, params[:code])
  ```

### Checkout and payments process

1. The flow begins with the creation of a Checkout Preference

  ```ruby
    options = {
      back_url: 'The URL where the user will be redirected after doing the payment',
      notification_url: 'The URL for the IPN'
    }
    payable.mp_create_preference(options)
  ```
2. The Payable object now have the preference_id and the init_point, which is the URL where the user
can start the payment process

  ```ruby
    payable.mp_init_point
  ```

3. For handling the IPNs (Instant Payment Notification) use the Notification Class

  ```ruby
    payable = YourModelClass.find(params[:payable_id])
    mpn = Mercadopago::Notification.new(payable, params)
    mpn.handle_payment
  ```

That's it. Now we can access the MercadopagoPayment objects associated to a Payable object:

```ruby
  payable.mercadopago_payments
```

## Implementation details

### Basic classes

#### [config.rb](../app/mercadopago/mercadopago/config.rb)


This class gets the configuration from an YML file, it is used by other classes.
The YML file must be put in ```/config/mercadopago.yml``` and must have the following structure:

```yaml
app_id: 1234567890
app_secret: 9078c4cf36e4caeaf221dcb591
auth_url: https://auth.mercadopago.com.ar/authorization
oauth_url: https://api.mercadopago.com/oauth/token
link_redirect_uri: http://myapp.com/mercadopago/notification
```

You can also use environment variables instead of this config file. Use the prefix `MERCADOPAGO_` 
and uppercase the name of the variables. Example:

```bash
export MERCADOPAGO_APP_ID="1234567890"
export MERCADOPAGO_APP_SECRET="9078c4cf36e4caeaf221dcb591"
```

#### [session.rb](../app/mercadopago/mercadopago/session.rb)

This encapsulates a MercadoPago object and handles the type of connection with MercadoPago. If it's
through the application credentials or through a third party user (marketplace).

### Mercadopago Connect

#### [connect.rb](../app/mercadopago/mercadopago/connect.rb)

Handles the feature of connecting a user with our application.



Official documentation: https://www.mercadopago.com.ar/developers/en/solutions/payments/custom-checkout/mercadopago-connect/

### Payments and Notifications

#### [payable.rb](../app/mercadopago/mercadopago/payable.rb)

This module must be included in the model that represents a concept that users should pay for.
For example: ```Reservation``` or ```Product```

#### [preference.rb](../app/mercadopago/mercadopago/preference.rb)

Handles the creation of Checkout Preferences

Official documentation: https://www.mercadopago.com.ar/developers/en/api-docs/basic-checkout/checkout-preferences/

#### [notification.rb](../app/mercadopago/mercadopago/notification.rb)

Handles the IPNs that the MercadoPago issues to our application.

Everytime you create a Checkout Preference and the user goes to the link generated (init_point), a merchant order will be created and you will be notified. Everytime a payment is made or it changes it's state you will receive a payment notification. You need to tell MercadoPago you received this notifications (200 or 201). Configure your app IPN (https://www.mercadopago.com/mla/herramientas/notificaciones) with an endpoint reserved to receive notifications. 



