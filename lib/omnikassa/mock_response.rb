module Omnikassa

  #  MockResponse.success(:ideal, { amount: 120 })
  #  MockResponse.success(:ideal, { amount: 120 })

  class MockResponse

    DEFAULTS = { amount: '1234',
                 captureDay: '0',
                 captureMode: 'AUTHOR_CAPTURE',
                 currencyCode: '978',
                 merchantId: '002020000000001',
                 orderId: "null",
                 transactionDateTime: "2012-05-05T15:20:25+02:00",
                 transactionReference: "12312322",
                 keyVersion: "1"
                 }

    SUCCESS = { ideal: {
                  authorisationId: "0020000006791167",
                  paymentMeanBrand: "IDEAL",
                  paymentMeanType: "CREDIT_TRANSFER",
                  responseCode: '00'
                },
                mastercard: {
                  authorisationId: '020704',
                  complementaryCode: '99',
                  maskedPan: '5209##########69',
                  paymentMeanBrand: 'MASTERCARD',
                  paymentMeanType: 'CARD',
                  responseCode: '00'
                },
                visa: {
                  authorisationId: '930730',
                  complementaryCode: '00',
                  maskedPan: '4563##########99',
                  paymentMeanBrand: 'VISA',
                  paymentMeanType: 'CARD',
                  responseCode: '00'
                }
                }


    FAILURE = {
      ideal: {
      },
      cancelled: {
        authorisationId: '0020000529634199',
        complementaryCode: '',
        maskedPan: '',
        paymentMeanBrand: 'IDEAL',
        paymentMeanType: 'CREDIT_TRANSFER',
        responseCode: '17',
      },
      mastercard: {
        complementaryCode: '02',
        maskedPan: '5475##########35',
        paymentMeanBrand: 'MASTERCARD',
        paymentMeanType: 'CARD',
      },

      do_not_honor: {
        authorisationId: '',
        responseCode: '05'
      },

      time_out: {
        responseCode: '97'
      }

    }

    # .success(:ideal | :mastercard)
    def self.success(provider, args = {})
      generate DEFAULTS.merge(SUCCESS[provider]).merge(args)
    end

    def self.failure(provider, reason, args = {} )
      generate DEFAULTS.merge(FAILURE[provider]).merge(FAILURE[reason]).merge(args)
    end

    private

    def self.generate(args)
      data = Data.serialize(args)
      seal = Omnikassa::sign(data)
      { 'Data' => data, 'Seal' => seal, 'InterfaceVersion' => 'HP_1.0' }
    end
  end
end
