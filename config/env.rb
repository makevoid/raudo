require 'bundler'
Bundler.require :default
require 'securerandom'

path    = File.expand_path "../../", __FILE__
PATH    = path
env     = ENV["RACK_ENV"] || "development"
APP_ENV = env

ALLOWED_USERS = [
  "makevoid@gmail.com",
  # "edward@tallysticks.io",
  # "filippo.oretti@gmail.com",
  # "720kb.net@gmail.com",
  # "okkio84@gmail.com",
]

CONFIG = {}


DEV_USERNAME = `whoami`.strip
gauth_config_path = if DEV_USERNAME == "45kb"
  "#{PATH}/.google_auth"
else
  "~/.google_auth"
end

# TODO: auto generate key with: SecureRandom.base64 and write if not present
auth = File.read(File.expand_path gauth_config_path)
identifier, secret = auth.split("|").map &:strip

CONFIG[:google_oauth_identifier]  = identifier
CONFIG[:google_oauth_secret]      = secret


require "#{path}/lib/execution"
require "#{path}/lib/remote_execution"
require "#{path}/lib/notify"

Dir["#{path}/models/*.rb"].each do |app|
  require app
end

# aliases
AppInst = AppInstance


# require "#{PATH}/lib/passenger_eventmachine_runner"
# PassengerEventmachineRunner.start


R = Redis.connect

require "#{PATH}/lib/event_stream"


# Test app config:

# url: https://console.developers.google.com
#      https://console.developers.google.com/project/PROJECT/apiui/credential

# Authorized JavaScript origins
#
#   http://mkvd.eu.ngrok.com

# Authorized redirect URIs
#
#   http://mkvd.eu.ngrok.com/auth/google_oauth2/callback


# TODO: require_relative lib/exec
#       require_relative models
