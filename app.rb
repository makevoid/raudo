require_relative "./config/env"

class App < Sinatra::Base

  # oauth

  enable :sessions
  set :session_secret, CONFIG[:session_secret]

  use OmniAuth::Builder do
    provider :google_oauth2, CONFIG[:google_oauth_identifier], CONFIG[:google_oauth_secret]
  end

  before do
    if request.env['omniauth.auth'].nil? && !logged_in?
      halt haml(:log_in)
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


  # main

  get "/" do
    haml :index
  end

end
