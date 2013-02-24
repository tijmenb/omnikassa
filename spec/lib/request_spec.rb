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
      request.data_string.should eq "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|transactionReference=1223123123|keyVersion=1|customerLanguage=nl"
    end

    it 'seals' do
      request.seal.should eq "a1d02cfb17b1f804740847879aeb6125030adff23a1b6845f0ed486370d4dc92"
    end

    it 'has interface' do
      request.interface_version.should eq "HP_1.0"
    end

    it 'has the url' do
      request.url.should eq "https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet"
    end
  end

  describe 'overriding language' do
    it 'uses the provided language' do
      request = Omnikassa::Request.new(amount: 1234, return_url: 'RETURN', response_url: 'RESPONSE', reference: 1223123123, language: 'en' )
      request.data_string.should eq "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|transactionReference=1223123123|keyVersion=1|customerLanguage=en"
    end
  end
end
