# Load the Rails application.
require_relative "application"

#load environment_variables.rb
environment_varibles = File.join(Rails.root, 'config', 'environment_varibles.rb')
load(environment_varibles) if File.exist?(environment_varibles)

# Initialize the Rails application.
Rails.application.initialize!
