require 'bundler/setup'
Bundler.require :default

path    = File.expand_path "../../", __FILE__
PATH    = path
env     = ENV["RACK_ENV"] || "development"
APP_ENV = env

ALLOWED_USERS = [
  "makevoid@gmail.com",
  "filippo.oretti@gmail.com",
  "720kb.net@gmail.com"
]

CONFIG = {}

DEV_USERNAME = `whoami`.strip
gauth_config_path = if DEV_USERNAME == "45kb"
  "#{PATH}/.google_auth"
else
  "~/.google_auth"
end

auth = File.read(File.expand_path gauth_config_path)
identifier, secret = auth.split("|").map(&:strip)

puts identifier
puts secret

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


# url: https://console.developers.google.com
#      https://console.developers.google.com/project/PROJECT/apiui/credential

# Authorized JavaScript origins
#
#   http://1b69e9da.ngrok.com

# Authorized redirect URIs
#
#   http://1b69e9da.ngrok.com/auth/google_oauth2/callback


# TODO: require_relative lib/exec
#       require_relative models
