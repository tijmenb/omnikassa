require 'spec_helper'

describe Omnikassa::Data do
  it 'can parse the return values from Rabo' do
    @valid_params = {'Data'=>'amount=1234|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-04T15:52:56+02:00|transactionReference=23233|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00', 'InterfaceVersion'=>'HP_1.0', 'Encode'=>'', 'Seal'=>'296db7c33289d142e3246b5e0cb3dd02168e1d73497974f90db20dd8a399754e'}

    response = Omnikassa::Data.unserialize(@valid_params['Data'])
    response[:amount].should eq '1234'
    response[:captureDay].should eq '0'
    response[:transactionReference].should eq '23233'
    response[:authorisationId].should eq '0020000006791167'
  end
end
