require 'config'
require 'harvested'

module Harvest
  class ApiClient

    include Singleton

    def initialize
      @client = Harvest.client(Config.instance.harvest)
    end

    def method_missing(name, *args, &block)
      @client.send(name, *args, &block)
    end
  end
end