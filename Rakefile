$LOAD_PATH.unshift('lib')

require 'runner'
require 'config'

task default: :run

task :run do
  client_config = Config.for(:lale)
  Runner.run(client_config)
end