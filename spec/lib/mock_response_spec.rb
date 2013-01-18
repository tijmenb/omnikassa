require 'spec_helper'

describe Omnikassa::MockResponse do
  describe '.generate' do

    it 'generates without error' do
      Omnikassa::MockResponse.success(:ideal)
      Omnikassa::MockResponse.success(:mastercard)
      Omnikassa::MockResponse.success(:visa)

      Omnikassa::MockResponse.failure(:mastercard, :time_out)
      Omnikassa::MockResponse.failure(:mastercard, :do_not_honor)
      Omnikassa::MockResponse.failure(:ideal, :cancelled)
    end
  end
end
