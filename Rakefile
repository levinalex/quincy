require 'lib/quincy'

require 'hoe'
require 'anyforge'

version = Quincy::VERSION::STRING

Hoe.new("quincy", version) do |p|
  # p.rubyforge_name = "quincy"
  p.author = "Levin Alexander"
  p.email = "mail@levinalex.net"
  p.url = "http://levinalex.de/ruby/quincy"
  p.summary = "Reads patient data from QuincyPCnet, <http://www.frey.de/q_pcnet.htm>"
end

Rake.application.instance_eval { @tasks["test"] = nil }
task :test do
  sh "spec -c -f specdoc spec/"
end

