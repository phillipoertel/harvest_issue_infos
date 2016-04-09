class Config

  include Singleton

  def self.for(client_name)
    instance.for(client_name)
  end

  def initialize
    @config = YAML.load_file('config/config.yml')
  end

  def harvest
    symbolize_keys(@config['harvest'])
  end

  def for(client_name)
    @config['clients'].find { |k, v| k.to_s == client_name.to_s }.last
  end

  private

  def symbolize_keys(input)
    input.inject({}) { |hash, (key, value)| hash[key.to_sym] = value; hash }
  end

end