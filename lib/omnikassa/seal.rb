module Omnikassa
  def self.seal(string)
    hash = Digest::SHA2.new << string
    hash.to_s
  end

  def self.sign(data)
    Omnikassa::seal(data+ Omnikassa.configuration.secret_key)
  end
end
