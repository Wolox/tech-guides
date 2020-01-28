#  WebPay

## Description

[WebPay](https://www.webpay.cl/) is one of the payment solutions of [Transbank](https://publico.transbank.cl/) in Chile. It's main goal is to provide digital businesses a way to manage their online payment channels. [Here](https://transbankdevelopers.cl/referencia/webpay?l=ruby#webpay) is the official api documentation, [environment credentials](https://github.com/TransbankDevelopers/transbank-webpay-credenciales/) and the [gem](https://transbankdevelopers.cl/documentacion/como_empezar#instalacion-sdk) used.

## Implementation

WebPay was used in Papa John's project.

Ruby on Rails implementation:

- [Service](https://github.com/Wolox/pj-orders-rails/tree/development/app/services/payments/webpay) and [tests](https://github.com/Wolox/pj-orders-rails/tree/development/spec/services/payments/webpay)
- [Interactors](https://github.com/Wolox/pj-orders-rails/tree/development/app/interactors/payments) and [tests](https://github.com/Wolox/pj-orders-rails/tree/development/spec/interactors/payments)
- [Controller](https://github.com/Wolox/pj-orders-rails/blob/development/app/controllers/api/v1/payments/webpay_controller.rb) and [tests](https://github.com/Wolox/pj-orders-rails/blob/development/spec/controllers/api/v1/payments/webpay_controller_spec.rb)

React Native Implementation:

- [Webview](https://github.com/Wolox/pj-app-react-native/tree/production/src/app/components/CustomWebView)
- [Redux Actions](https://github.com/Wolox/pj-app-react-native/blob/production/src/redux/payment/actions.js#L128) 
- [Pooling Service](https://github.com/Wolox/pj-app-react-native/blob/production/src/services/OrderService.js#L75)

## Pain Points

- Although Transbank has an official Slack account with an active community, it can be hard to have direct contact/help from their support team.
- Getting production credentials can take some time.
- Some of the documentation is either incomplete or incorrect.

## Alternatives

- OneClick. Tokenizes the user's credit card for easier following transactions.
- OnePay. Uses a mobile app to validate the transaction.

## Estimation

### Backend

- The full implementation of this integration was estimated in 100hs. Copying this code should reduce this hours around 30.
- Consider extra time for getting production credentials and obtaining Transbank's validation.
- Check if the client needs the standard integration or the Mall integration, which is a different way of organizing transaction data.

### Mobile

- The full implementation of this integration was estimated in 30hs.
