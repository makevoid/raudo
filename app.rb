require_relative "./config/env"
# require "sinatra/content_for"
# require "sinatra/streaming"
require 'json'

Logger.class_eval { alias :write :'<<' }
LOGG = Logger.new STDOUT

class App < Sinatra::Base
  set :logger, LOGG

  configure do
    use Rack::CommonLogger, LOGG
  end

  include Voidtools::Sinatra::ViewHelpers

  # oauth

  enable :sessions
  set :session_secret, CONFIG[:session_secret]

  use OmniAuth::Builder do
    provider :google_oauth2, CONFIG[:google_oauth_identifier], CONFIG[:google_oauth_secret]
  end
  OmniAuth.config.allowed_request_methods = %i[get]


  set :show_exceptions, false

  error do
    content_type :json
    error = env['sinatra.error']
    { error: { name: error.class, message: error.message, backtrace: error.backtrace } }.to_json
  end

  PUBLIC_URLS = %w(
    /stream
    /auth/google_oauth2
  )

  before do
    if APP_ENV != "development"
      if request.env['omniauth.auth'].nil? && !logged_in? && !(PUBLIC_URLS.include? request.path)
        halt haml(:log_in)
      end
    else
      halt haml(:log_in) if params[:login]
    end
  end

  def logged_in?
    current_user && ALLOWED_USERS.include?(current_user)
  end

  def current_user
    session[:current_user]
  end

  post "/logout" do
    session[:current_user] = nil
    redirect "/"
  end

  get '/auth/:name/callback' do
    auth = request.env['omniauth.auth']
    user = auth.info.email
    session[:current_user] = user
    redirect "/"
  end

  # helpers

  helpers do
    def nav_link(label)
      url   = "/#{label.downcase}"
      # klass = "active" if request.path =~ /^#{url}/
      # haml_tag :li, class: klass do
      #   haml_tag :a, href: url do
      #     haml_concat label
      #   end
      # end
      "<li><a href=\"#{url}\">#{label}</a></li>"
    end
  end

  # main

  get "/" do
    haml :index
  end

  get "/apps" do
    haml :apps
  end

  get "/domains" do
    haml :domains
  end

  get "/machines" do
    haml :machines
  end

  # apps

  post /\/apps\/(.+)\/actions/ do |app_name|
    content_type :json
    request.body.rewind
    payload = JSON.parse(request.body.read)
    action  = payload["name"].to_sym
    ActionJob.new.async.perform(
      event:       action,
      app:         app_name
    )
    { name: app_name }.to_json
  end


  post "/apps" do
    content_type :json
    request.body.rewind
    payload  = JSON.parse(request.body.read)
    app_name = payload["name"].to_sym
    CreateJob.new.async.perform(
      app:         app_name
    )
    { name: app_name }.to_json
  end

  get '/stream' do
    [200, { "Content-Type" => "text/event-stream;charset=utf-8" }, EventStream.instance]
  end

end
