require 'spec_helper'

describe Omnikassa::Request do
  it 'creates a valid request object' do
    omni = Omnikassa::Request.new(
      amount: 1234,
      return_url: 'RETURN',
      response_url: 'RESPONSE',
      reference: 1223123123
    )

    expected = {
      :data => "currencyCode=978|merchantId=002020000000001|normalReturnUrl=RETURN|automaticResponseUrl=RESPONSE|amount=1234|transactionReference=1223123123|keyVersion=1",
      :seal => "f8b0a4e47bda058be0a2407301b463315c55febf11068660d72f180494313496",
      :interface => "HP_1.0",
      :url => "https://payment-webinit.simu.omnikassa.rabobank.nl/paymentServlet"
    }

    omni.post_fields.should eq expected
  end
end
