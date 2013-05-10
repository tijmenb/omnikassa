[![Build Status](https://travis-ci.org/tijmenb/omnikassa.png?branch=master)](https://travis-ci.org/tijmenb/omnikassa)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tijmenb/omnikassa)

# Omnikassa

De Omnikassa Gem is een wrapper voor [Rabobank's Omnikassa](http://www.rabobank.nl/bedrijven/producten/betalen_en_ontvangen/geld_ontvangen/rabo_omnikassa/).

## Usage

Configureer de app met je gegevens:

```ruby
# config/initializers/omnikassa.rb
Omnikassa.configure do |config|
  config.merchant_id =  '002020000000001'
  config.secret_key =  '002020000000001_KEY1'
  config.environment = :test
end
```

Maak een request aan in de controller:

```ruby
# controllers/payment_controller.rb
def payment
  @omnikassa_request = Omnikassa::Request.new(
    amount: 1234, # bedrag in centen
    return_url: payment_return_url, # de URL waar de user naartoe gaat na betaling
    response_url: payment_response_url, # URL waar Rabo naar POST na een betaling
    reference: '1223123123' # Een unieke identifier voor je transactie
  )
end
```

Een form voor de redirect:

```erb
<%= form_tag @omnikassa_request.url do |f| %>
  <%= hidden_field_tag 'Data', @omnikassa_request.data_string %>
  <%= hidden_field_tag 'InterfaceVersion', @omnikassa_request.interface_version %>
  <%= hidden_field_tag 'Seal', @omnikassa_request.seal %>
  <%= submit_tag 'Naar betaling' %>
<% end %>
```

Als de user heeft betaald, dan wordt hij geredirect naar `payment_return_url`.

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

Maar die redirect is niet gegarandeerd, dus je doet de afhandeling van de betaling in de callback.

```ruby
# controllers/payment_controller.rb
def payment_response
  response = Omnikassa::Response.new(params)
  if response.success?
    # sla de betaling op in de database
  else
    # doe iets anders
  end
end
```

## Specs

Om je eigen applicatie te testen is er `Omnikassa::Mocks`. Hier vind je POST-data zoals die door Rabo worden gestuurd bij een transactie. Dit zorgt ervoor dat je niet handmatig alle responses van Rabobank hoeft te testen. 

**iDEAL betaling**

- `ideal_ok`: Betaling gelukt
- `ideal_cancelled`: Betaling is afgebroken door de gebruiker
- `ideal_verlopen`: Betaling is verlopen
- `ideal_geopend`: Geen idee.
- `ideal_error`: technische fout bij Rabo.

Todo: Minitix, Card, etc.

Je kan zoiets doen in rspec:

```ruby
describe CheckoutController do
  it 'can handle a response from rabo' do
    post :return_payment, Omnikassa::Mock.ideal_ok
    assigns(:payment).status.should equal 'paid'
  end
end
```
