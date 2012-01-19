load 'deploy' if respond_to?(:namespace)
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy'

# basics
#load 'config/deploy/sudo_everywhere'
#load 'config/deploy/settings'

# daemons
#load 'config/deploy/services'
#load 'config/deploy/queue'
#load 'config/deploy/import'
#load 'config/deploy/gem_eval'

# deployment tasks
#load 'config/deploy/symlinks'

# candy
#load 'config/deploy/notify'
