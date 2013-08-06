[![Build Status](https://travis-ci.org/tijmenb/omnikassa.png?branch=master)](https://travis-ci.org/tijmenb/omnikassa)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tijmenb/omnikassa)
[![Gem Version](https://badge.fury.io/rb/omnikassa.png)](http://badge.fury.io/rb/omnikassa)

## Rabobank Omnikassa

Omnikassa is a Rails gem for [Rabobank's Omnikassa](http://www.rabobank.nl/bedrijven/producten/betalen_en_ontvangen/geld_ontvangen/rabo_omnikassa/). We use manual [handleiding 4.1](http://www.rabobank.nl/images/rabobank_omnikassa_integratiehandleiding_versie_4_1_december_2012_29420242.pdf) (Dutch).

This gem is not affiliated with the Rabobank.

### Installation

Install the gem and create an initializer.

```ruby
# Gemfile
gem 'omnikassa', '~> 0.0.2'

# config/initializers/omnikassa.rb
Omnikassa.configure do |config|
  config.merchant_id =  '002020000000001'
  config.secret_key =  '002020000000001_KEY1'
  config.environment = :test
end
```

Above are the official testing credentials from Rabo, so you don't have to use key and secret to run a test. 

### Quickstart

Create a request in your controller:

```ruby
# controllers/payment_controller.rb
def payment
  @omnikassa_request = Omnikassa::Request.new(
    amount: 1234, # transaction amount in cents
    reference: '1223123123', # A unique identifier for the transaction
    return_url: payment_return_url, 
    response_url: payment_response_url
  )
end
```

Then create a form that will POST the data you just provided to the Omnikassa:

```erb
# views/payments/payment.html.erb
<%= form_tag @omnikassa_request.url do |f| %>
  <%= hidden_field_tag 'Data', @omnikassa_request.data_string %>
  <%= hidden_field_tag 'InterfaceVersion', @omnikassa_request.interface_version %>
  <%= hidden_field_tag 'Seal', @omnikassa_request.seal %>
  <%= submit_tag 'Naar betaling' %>
<% end %>
```

After a user has completed the payment, he is redirected to the URL we specified as `return_url`. You can show a message depending on the outcome of the payment.

```ruby
# controllers/payment_controller.rb
def payment_return
  @response = Omnikassa::Response.new(params)
  if response.success?
    render :success
  else
    render :error
  end
end
```

Immediately after a payment is completed, Rabobank will send a POST-request to whatever URL we specified in `response_url`. Use this to save the payment to the database, send out emails, etc. 

```ruby
# controllers/payment_controller.rb
def payment_response
  response = Omnikassa::Response.new(params)
  if response.success?
    # update database
  else
    # don't update, send out warning, etc
  end
end
```

### Configurations and defaults

```ruby
# config/initializers/omnikassa.rb
Omnikassa.configure do |config|
  config.merchant_id =  '002020000000001'
  config.secret_key =  '002020000000001_KEY1'
  config.environment = :test
  key_version = 1,
  currency_code = 978, # EURO
  language =  'nl',
  payment_methods: [:ideal, :minitix, :visa, :mastercard, :maestro, :incasso, :acceptgiro, :rembours]
end
```

### Sending a pull request

Very welcome!

1. [Fork the project](https://help.github.com/articles/fork-a-repo).
2. Create a branch - `git checkout -b adding_magic`
3. Make your changes, and add some tests!
4. Check that the tests pass - `bundle exec rake`
5. Commit your changes - `git commit -am "Added some magic"`
6. Push the branch to Github - `git push origin adding_magic`
7. Send us a [pull request](https://help.github.com/articles/using-pull-requests)!

### License

Copyright (C) 2013 by Tijmen Brommet. Published under the MIT license. See LICENSE.md for details.
