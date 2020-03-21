# environment.rb
# frozen_string_literal: true

# get the path of the root of the app
APP_ROOT = File.expand_path('..', __dir__)

# require app.rb
require File.join(APP_ROOT, 'app')

# require the controller(s)
Dir.glob(File.join(APP_ROOT, 'app', 'controllers', '**/*.rb')).each { |file| require file }

# require the model(s)
Dir.glob(File.join(APP_ROOT, 'app', 'models', '*.rb')).each { |file| require file }

# require database configurations
require File.join(APP_ROOT, 'config', 'database')

