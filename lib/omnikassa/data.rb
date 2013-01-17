module Omnikassa
  class Data
    def self.serialize(hash)
      hash.map { |k,v| "#{k}=#{v}"}.join('|')
    end

    def self.unserialize(string)
      string.split("|").reduce({}) do |hash, key_value|
        k, v = key_value.split "="
        hash[k.to_sym] = v
        hash
      end
    end
  end
end
