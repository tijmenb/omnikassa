[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tijmenb/omnikassa)

# Omnikassa

De Omnikassa Gem is een wrapper voor Rabobank's Omnikassa.

## Hoe Omnikassa werkt

Omnikassa werkt in twee stappen:

1. Je laat de user een POST-request maken naar Rabobank. Daar betaalt de user met iDeal, Minitix of Credit Card.

2. Als de transactie voltooid is, wordt de user weer redirect naar de app.

## Gebruik

### 1. Configureer de app met je gegevens.

```ruby
Omnikassa.configure do |config|
  config.merchant_id =  '002020000000001'
  config.secret_key =  '002020000000001_KEY1'
  config.key_version = 1
  config.currency_code = 978
  config.rabobank_url = 'https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet'
end
```


### 2. In een controller:

```ruby
def payment
  @omnikassa_request = Omnikassa::Request.new(
    amount: 1234, # bedrag in centen
    return_url: payment_return_url(), # de URL waar de user naartoe gaat na betaling
    response_url: payment_response_url(), # URL waar Rabo naar POST na een betaling
    reference: 1223123123 # Een unieke identifier voor je transactie
  )
end
```

### 3. In de view van die controller:

```erb
<%= form_tag @omnikassa_request.url do |f| %>
  <%= hidden_field_tag 'Data', @omnikassa_request.data_string %>
  <%= hidden_field_tag 'InterfaceVersion', @omnikassa_request.interface_version %>
  <%= hidden_field_tag 'Seal', @omnikassa_request.seal %>
  <%= submit_tag 'Naar betaling' %>
<% end %>
```

### 4. Nog een method als de user terugkomt:

```ruby
def payment_return
  @response = Omnikassa::Response.new(params)
  if response.success?
    render :success
  else
    render :error
  end
end
```

### 4. En nog een method waar de Rabo server naartoe POST:

```ruby
def payment_response
  response = Omnikassa::Response.new(params)
  if response.success?
    # sla de betaling op in de database
  else
    # doe iets anders
  end
end
```

### 5. En in je routes:

```ruby
get 'checkout/payment' => 'checkout#payment'
post 'checkout/payment_return' => 'checkout#payment_return', :as => :payment_return
post 'checkout/payment_response' => 'checkout#payment_response', :as => :payment_response
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

### Gebruik

Je kan zoiets doen in rspec:

```ruby
describe CheckoutController do
  it 'can handle a response from rabo' do
    post :return_payment, Omnikassa::Mock.ideal_ok
    assigns(:payment).status.should equal 'paid'
  end
end
```
