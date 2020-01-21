#  WebPay

## Description

[WebPay](https://www.webpay.cl/) is one of the payments portal of [Transbank](https://publico.transbank.cl/) from Chile. It's main goal is to provide digital businesses an alternative to manage their payment channel. [Here](https://transbankdevelopers.cl/referencia/webpay?l=ruby#webpay) is the official api documentation, [environment credentials](https://github.com/TransbankDevelopers/transbank-webpay-credenciales/) and the [gem](https://transbankdevelopers.cl/documentacion/como_empezar#instalacion-sdk) used.

## Integration flow

## Implementation

WebPay was used in Papa Jhon's project, developed in Ruby on Rails:

- [Service](https://github.com/Wolox/pj-orders-rails/tree/development/app/services/payments/webpay) and [tests](https://github.com/Wolox/pj-orders-rails/tree/development/spec/services/payments/webpay)
- [Interactors](https://github.com/Wolox/pj-orders-rails/tree/development/app/interactors/payments) and [tests](https://github.com/Wolox/pj-orders-rails/tree/development/spec/interactors/payments)
- [Controller](https://github.com/Wolox/pj-orders-rails/blob/development/app/controllers/api/v1/payments/webpay_controller.rb) and [tests](https://github.com/Wolox/pj-orders-rails/blob/development/spec/controllers/api/v1/payments/webpay_controller_spec.rb)

## Pain Points

No pain points where found using webpay

## Alternatives

- OneClick

## Estimation

- Backend: 80hs
