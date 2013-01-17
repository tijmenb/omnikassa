module Omnikassa
  class Response

    attr_accessor :data, :raw_data, :seal

    def initialize(params)
      self.data      = Data.unserialize(params['Data'])
      self.raw_data  = params['Data']
      self.seal      = params['Seal']
    end

    # Check of de response een geldige seal heeft
    def legit?
      Omnikassa::seal(raw_data + Omnikassa.configuration.secret_key) === seal
    end

    def success?
      response_code === '00' && legit?
    end

    # Valuta
    def currency
      Omnikassa::CURRENCY_CODES[data[:currencyCode]]
    end

    # De merchant ID.
    def merchant_id
      data[:merchantId]
    end

    # Bedrag van de transactie in centen
    def amount
      data[:amount]
    end

    def reference
      data[:transactionReference]
    end

    def response_code
      data[:responseCode]
    end

    def response
      Omnikassa::RESPONSE_CODES[response_code]
    end

    # Niet duidelijk wat dit is.
    def authorization_id
      data[:authorisationId]
    end

    # CREDIT_TRANSFER, CARD, OTHER
    def payment_type
      data[:paymentMeanType]
    end

    # IDEAL, VISA, MASTERCARD, MAESTRO, MINITIX, INCASSO, ACCEPTGIRO, REMBOURS
    def payment_service
      data[:paymentMeanBrand]
    end

    # Nog niet beschikbaar: keyVersion, orderId, complementaryCode, maskedPan
  end
end
