require "resque"
require "resque_mailer"
require "resque_scheduler"

Dir[File.join(Rails.root, "app", "jobs", "*.rb")].each {|file| require file}

config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
Resque.redis = Redis.new(:host => config[:host], :port => config[:port])

#Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60) # 24hrs in seconds