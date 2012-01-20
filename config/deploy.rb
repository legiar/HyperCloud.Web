require "bundler/capistrano"
require "capistrano_colors"

set :application, "HyperCloud.Web"
set :rails_env, "production"

set :deploy_to, "/home/webmaster/#{application}"
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :scm, :git
set :git_enable_submodules, 1
set :repository, "git://github.com/legiar/HyperCloud.Web.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "webmaster"
set :use_sudo, false
host = "cloud.bpmonline.com"

role :web, host
role :app, host
role :db,  host, :primary => true

after "deploy:update", "deploy:cleanup"
after "deploy:update_code", "config:symlink_app_config"
after "deploy:symlink", "config:symlink_app_config"
before "deploy:assets:precompile", "bundle:install"
before "deploy:assets:precompile", "config:symlink_app_config"

namespace :config do
  task :symlink_app_config do
    run "ln -sf #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
    #run "ln -sf #{deploy_to}/shared/config/unicorn.rb #{current_release}/config/unicorn.rb"
  end
end

namespace :deploy do
  task :restart, :roles => :app do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  
  task :start do
    run "cd #{current_path} && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
  
  after "deploy:setup" do
    run "mkdir -p #{deploy_to}/shared/config"
    run "mkdir -p #{deploy_to}/shared/sockets"
  end
end

after 'deploy:update',  'bundle:install'
#after 'deploy:restart', 'unicorn:stop'

