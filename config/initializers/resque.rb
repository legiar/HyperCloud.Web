require "resque"
require "resque/server"
require "resque_mailer"
require "resque_scheduler"
Dir[File.join(Rails.root, "app", "jobs", "*.rb")].each {|file| require file}

config = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env]
Resque.redis = Redis.new(:host => config[:host], :port => config[:port])

class CanAccessResque
  def self.matches?(request)
    current_user = request.env['warden'].user
    return false if current_user.blank?
    Ability.new(current_user).can? :manage, Resque
  end
end