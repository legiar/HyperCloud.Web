# unicorn_rails -c config/unicorn.rb -E production -D
app_path = File.expand_path(File.dirname(__FILE__) + "/../..")

rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes (rails_env == 'production' ? 16 : 4)
preload_app true
timeout 30

pid "#{app_path}/current/tmp/pids/unicorn.pid"
listen "#{app_path}/shared/sockets/unicorn.sock", :backlog => 2048

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.
  old_pid = "#{app_path}/current/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
  worker.user(username, group) if Process.euid == 0 && rails_env == "production"
end

