require 'omnikassa'

Omnikassa.configure do |config|
  config.merchant_id =  '002020000000001'
  config.secret_key =  '002020000000001_KEY1'
  config.key_version = 1
  config.currency_code = 978
  config.rabobank_url = 'https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet'
  config.language = 'nl'
  config.payment_methods = [:ideal, :minitix, :visa, :mastercard, :maestro, :incasso, :acceptgiro, :rembours]
end
