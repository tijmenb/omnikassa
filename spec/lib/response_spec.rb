require 'spec_helper'

describe Omnikassa::Response do

  let(:fake_response) { Omnikassa::MockResponse.success(:ideal, transactionReference: 1111) }

  describe '.legit?' do
    it 'can read a request object and validate it against the seal' do
      resp = Omnikassa::Response.new(fake_response)
      resp.legit?.should be true
    end

    it 'can read a request object and know its not valid' do
      invalid = fake_response
      invalid['Seal'] = '2398462'
      resp = Omnikassa::Response.new(invalid)
      resp.legit?.should be false
    end
  end

  describe 'convenience methods' do
    it 'has the right values' do
      resp = Omnikassa::Response.new(fake_response)

      resp.reference.should eq '1111'
      resp.amount.should eq '1234'
      resp.currency.should eq 'euro'
      resp.merchant_id.should eq '002020000000001'
      resp.response_code.should eq '00'
      resp.response.should eq 'Transaction success, authorization accepted.'

      # Normale iDeal betaling
      resp.authorization_id.should eq '0020000006791167'
      resp.payment_type.should eq 'CREDIT_TRANSFER'
      resp.payment_service.should eq 'IDEAL'

      # Gelukt?
      resp.success?.should eq true
    end
  end

  describe '.success' do
    it 'technical error' do
      resp = Omnikassa::Response.new(Omnikassa::MockResponse.failure(:ideal, :time_out))
      resp.success?.should be false
      resp.response.should eq 'Request time-out; transaction refused'
    end
  end
end
