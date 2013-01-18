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
    @configuration ||= Configuration.new
  end
end
