require 'spec_helper'

describe Omnikassa::Request do

  describe 'normal request' do
    let(:request) {
      Omnikassa::Request.new(
        amount: 1234,
        return_url: 'RETURN',
        response_url: 'RESPONSE',
        reference: 1223123123
      )
    }

    it 'stringifies the data' do
      request.data_string.should eq "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|paymentMeanBrandList=IDEAL,MINITIX,VISA,MASTERCARD,MAESTRO,INCASSO,ACCEPTGIRO,REMBOURS|transactionReference=1223123123|keyVersion=1|customerLanguage=nl"
    end

    it 'seals' do
      request.seal.should eq "ad830c9c402a22a63d07b92973b0e5cbd9abc28d3d5b4ea6798e58effd848818"
    end

    it 'has interface' do
      request.interface_version.should eq "HP_1.0"
    end

    it 'returns the URL for prod if environment is production' do
      Omnikassa.configuration.environment = :production
      request.url.should eq "https://payment-webinit.omnikassa.rabobank.nl/paymentServlet"
    end

    it 'returns the URL for test if environment is test' do
      Omnikassa.configuration.environment = :test
      request.url.should eq "https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet"
    end
  end

  describe 'overriding language' do
    it 'uses the provided language' do
      request = Omnikassa::Request.new(amount: 1234, return_url: 'RETURN', response_url: 'RESPONSE', reference: 1223123123, language: 'en' )
      request.data_string.should eq "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|paymentMeanBrandList=IDEAL,MINITIX,VISA,MASTERCARD,MAESTRO,INCASSO,ACCEPTGIRO,REMBOURS|transactionReference=1223123123|keyVersion=1|customerLanguage=en"
    end
  end
end
