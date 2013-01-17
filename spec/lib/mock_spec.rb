require 'spec_helper'

describe Omnikassa::Mock do
  it 'returns a valid response hash' do
    res = Omnikassa::Mock.ideal_error(12312334)
    expected = { "Data" => "amount=500|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=null|transactionDateTime=2012-05-05T15:29:17+02:00|transactionReference=12312334|keyVersion=1|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=99", "InterfaceVersion" => "HP_1.0", "Seal" => "d1ea739b66eb85fc3a187ba2e046b8bb9aa7544351de7da22ec0532111287a9e"}
    res.should eq expected
  end

  it 'return an error if a scenario doesnt exist' do
    lambda { Omnikassa::Mock.nothing_here }.should raise_error
  end

end
