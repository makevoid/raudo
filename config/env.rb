require 'bundler/setup'
Bundler.require :default
PATH = File.expand_path "../../", __FILE__

ALLOWED_USERS = [
  "makevoid@gmail.com",
  "filippo.oretti@gmail.com"
]

CONFIG = {}

auth = File.read(File.expand_path "~/.google_auth")
identifier, secret = auth.split("|").map(&:strip)

puts identifier
puts secret

CONFIG[:google_oauth_identifier]  = identifier
CONFIG[:google_oauth_secret]      = secret


# url: https://console.developers.google.com
#      https://console.developers.google.com/project/PROJECT/apiui/credential

# Authorized JavaScript origins
#
#   http://1b69e9da.ngrok.com

# Authorized redirect URIs
#
#   http://1b69e9da.ngrok.com/auth/google_oauth2/callback
