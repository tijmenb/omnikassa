module Omnikassa
  class Request

    attr_accessor :amount, :return_url, :response_url, :reference, :language

    # request = Omnikassa::Request.new(
    #   amount: 1234, # bedrag in centen
    #   return_url: payment_return_url(), # de URL waar de user naartoe gaat na betaling
    #   response_url: payment_response_url(), # URL waar Rabo naar POST na een betaling
    #   reference: 1223123123 # Een unieke identifier voor je transactie
    # )
    def initialize(args)
      args.each do |key, value|
        self.send "#{key}=", value
      end
    end

    def url
      Omnikassa.configuration.rabobank_url
    end

    # Turn a has into a string like bla=bla|trala=trala
    def data_string
      Data.serialize(data)
    end

    def seal
      Omnikassa::seal(seal_seed)
    end

    def interface_version
      'HP_1.0'
    end

    private

    def seal_seed
      data_string + Omnikassa.configuration.secret_key
    end

    # The Data component
    def data
      {
        # Geef de valuta van de transactie aan.
        # Betreft een numerieke code van 3 tekens. Zie bijlage § 9.3.
        currencyCode: Omnikassa.configuration.currency_code,

        # ID (Identificatie‐gegeven) van de webwinkel
        merchantId: Omnikassa.configuration.merchant_id,

        # URL waarnaar de klant teruggeleid moet worden nadat de transactie afgerond is (URL voor handmatige respons).
        # Lengte is beperkt tot 512 tekens. LET OP! De URL mag geen parameters bevatten.
        normalReturnUrl: return_url,

        # URL waar Rabo naar toe POST na een betaling.
        automaticResponseUrl: response_url,

        # Bedrag van de transactie zonder decimaal scheidingsteken (bijv. 106,55 -> 10655).
        # Zie bijlage §9.3. Numerieke reeks, beperkt tot 12 tekens (maximaal bedrag is 999999999999)
        amount: amount,

        # Referentie van de Rabo OmniKassa‐transactie die uniek moet zijn voor elke ondernemer.
        # Alfanumerieke reeks, beperkt tot 35 tekens.
        transactionReference: reference,

        # Versie van de te gebruiken geheime sleutel (secretKey)
        # die door aan de ondernemer geleverd/bekend gemaakt wordt.
        keyVersion: Omnikassa.configuration.key_version,

        customerLanguage: language || Omnikassa.configuration.language
      }
    end
  end
end
