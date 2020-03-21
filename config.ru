# config.ru

$LOAD_PATH.unshift(File.expand_path('app', __dir__))
require File.expand_path('./config/environment.rb', __dir__)

run App
