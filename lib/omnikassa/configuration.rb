module Omnikassa
  class Configuration
    attr_accessor :merchant_id, :secret_key, :key_version,
      :currency_code, :rabobank_url
  end
end
