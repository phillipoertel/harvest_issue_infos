$LOAD_PATH.unshift('lib')

require 'runner'
require 'config'

task default: :run

desc "Generate the stats"
task :run do
  client_config = Config.for(:lale)
  Runner.run(client_config)
end