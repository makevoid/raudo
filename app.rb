require_relative "./config/env"

class App < Sinatra::Base

  include Voidtools::Sinatra::ViewHelpers

  # oauth

  enable :sessions
  set :session_secret, CONFIG[:session_secret]

  use OmniAuth::Builder do
    provider :google_oauth2, CONFIG[:google_oauth_identifier], CONFIG[:google_oauth_secret]
  end

  UNPROTECTED_URLS = ["/style.css", "style.css"]


  before do
    if APP_ENV != "development"
      if request.env['omniauth.auth'].nil? && !logged_in? && !(UNPROTECTED_URLS.include? request.path)
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
      klass = "active" if request.path =~ /^#{url}/
      haml_tag :li, class: klass do
        haml_tag :a, href: url do
          haml_concat label
        end
      end
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

  post "/apps/:id/actions" do
    "sei grande ciccio"
  end


  # style TODO change in prod

  get '/style.css' do
    content_type "text/css"
    File.read 'bower_components/materialize/dist/css/materialize.min.css'
  end

end
