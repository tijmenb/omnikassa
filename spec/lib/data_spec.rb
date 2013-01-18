require 'spec_helper'

describe Omnikassa::Data do

  describe '.serialize' do
    it 'turns a hash into a rabo string' do
      serialized = Omnikassa::Data.serialize(a: 'b', c: 'd')
      serialized.should eq 'a=b|c=d'
    end
  end

  describe ".unserialize" do
    let(:data_string) { 'amount=1234|captureDay=0|captureMode=AUTHOR_CAPTURE|' +
                        'currencyCode=978|merchantId=002020000000001|orderId=null|' +
                        'transactionDateTime=2012-05-04T15:52:56+02:00|' +
                        'transactionReference=23233|keyVersion=1|authorisationId=0020000006791167|' +
                        'paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00' }

    let(:unserialized) { Omnikassa::Data.unserialize(data_string) }

    it 'returns a hash' do
      unserialized.should be_a(Hash)
    end

    it 'returns the correct values' do
      unserialized[:amount].should eq '1234'
      unserialized[:captureDay].should eq '0'
      unserialized[:transactionReference].should eq '23233'
      unserialized[:authorisationId].should eq '0020000006791167'
    end
  end

end
