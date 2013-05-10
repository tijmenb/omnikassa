module Omnikassa
  class Configuration
    attr_accessor :merchant_id, :secret_key, :key_version,
      :currency_code, :rabobank_url, :language, :payment_methods,
      :environment

    def initialize(args)
      args.each do |k,v|
        self.send("#{k}=", v)
      end
    end
  end
end
