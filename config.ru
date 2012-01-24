require ::File.expand_path('../config/environment',  __FILE__)

run Rack::URLMap.new \
  "/" => HyperCloud::Application,
  "/resque" => Resque::Server.new
