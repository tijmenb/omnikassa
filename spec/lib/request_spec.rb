require 'spec_helper'

describe Omnikassa::Request do

  let(:request) {
    Omnikassa::Request.new(
      amount: 1234,
      return_url: 'RETURN',
      response_url: 'RESPONSE',
      reference: 1223123123
    )
  }

  it 'stringifies the data' do
    request.data_string.should eq "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|transactionReference=1223123123|keyVersion=1"
  end

  it 'seals' do
    request.seal.should eq "f8b0a4e47bda058be0a2407301b463315c55febf11068660d72f180494313496"
  end

  it 'has interface' do
    request.interface_version.should eq "HP_1.0"
  end

  it 'has the url' do
    request.url.should eq "https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet"
  end
end
