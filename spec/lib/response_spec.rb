require 'spec_helper'

describe Omnikassa::Response do

  before do
    @valid_params = {'Data'=>'amount=1234|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-04T15:52:56+02:00|transactionReference=23233|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00', 'InterfaceVersion'=>'HP_1.0', 'Encode'=>'', 'Seal'=>'296db7c33289d142e3246b5e0cb3dd02168e1d73497974f90db20dd8a399754e'}

    @invalid_params = { 'Data'=> 'amount=1234|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-04T15:52:56+02:00|transactionReference=23213|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00', 'InterfaceVersion'=>'HP_1.0', 'Encode'=>'', 'Seal'=>'296db7c33289d142e3246b5e0cb3dd02168e1d73497974f90db20dd8a399754e' }
  end


  it 'can read a request object and validate it against the seal' do
    resp = Omnikassa::Response.new(@valid_params)
    resp.legit?.should be true
  end

  it 'can read a request object and know its not valid' do
    resp = Omnikassa::Response.new(@invalid_params)
    resp.legit?.should be false
  end

  it 'has the right values' do
    resp = Omnikassa::Response.new(@valid_params)

    resp.reference.should eq '23233'
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


  describe 'iDEAL responses' do
    it 'ok' do
      resp = Omnikassa::Response.new(Omnikassa::Mock.ideal_ok(123))
      resp.success?.should be true
    end

    it 'technical error' do
      resp = Omnikassa::Response.new(Omnikassa::Mock.ideal_error)
      resp.success?.should be false
      resp.response.should eq 'Payment page temporarily unavailable'
    end
  end
end
