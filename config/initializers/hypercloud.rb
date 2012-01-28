require 'lib/breadcrumbs.rb'
require 'lib/shortcuts.rb'

Dir[File.join(Rails.root, "app", "workspaces", "*.rb")].each {|file| require file}