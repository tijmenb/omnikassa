require 'omnikassa/request'
require 'omnikassa/response'
require 'omnikassa/configuration'
require 'omnikassa/codes'
require 'omnikassa/mock_response'
require 'omnikassa/seal'
require 'omnikassa/data'
require 'digest'

module Omnikassa
  attr_writer :configuration

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new(
      key_version: 1,
      currency_code: 978, # EURO
      language: 'nl',
      environment: :test,
      payment_methods: [:ideal, :minitix, :visa, :mastercard, :maestro, :incasso, :acceptgiro, :rembours]
    )
  end
end
