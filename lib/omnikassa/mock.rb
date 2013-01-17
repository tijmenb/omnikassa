module Omnikassa

  class Mock
    MOCKS = {
      ideal: {
        ok: 'amount=1234|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:20:25+02:00|transactionReference=12312322|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00',
        cancelled: 'amount=200|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:26:51+02:00|transactionReference=12312327|keyVersion=1|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=17',
        verlopen: 'amount=300|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:28:34+02:00|transactionReference=12312331|keyVersion=1|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=97',
        geopend: 'amount=400|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:27:42+02:00|transactionReference=12312329|keyVersion=1|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=60',
        error: 'amount=500|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:29:17+02:00|transactionReference=12312334|keyVersion=1|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=99',
      }
    }

    def self.ideal_ok payment_id
      data = MOCKS[:ideal][:ok]
      data = data.gsub('12312322', payment_id.to_s)
      seal = Omnikassa::sign(data)
      { 'Data' => data, 'Seal' => seal, 'InterfaceVersion' => 'HP_1.0' }
    end

    def self.method_missing(method, *args, &block)
      service, result = method.to_s.split "_"
      super if MOCKS[service.to_sym].nil? || MOCKS[service.to_sym][result.to_sym].nil?

      data = MOCKS[service.to_sym][result.to_sym]
      seal = Omnikassa::sign(data)
      { 'Data' => data, 'Seal' => seal, 'InterfaceVersion' => 'HP_1.0' }
    end
  end

end
