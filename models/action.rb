# usage:
#
# Action.new.setup

require_relative 'conf'

class Action
  include RemoteExecution
  include Notify

  DIR_APPS   = Conf::DIR_APPS
  DIR_APP    = "/www/%s"        # usage: APP_DIR % "raudo"
  DIR_PUBLIC = "/www/%s/public" # usage: DIR_PUBLIC % "antani"

  # TASKS = %w(deploy restart setup db_create db_migrate)

  def deploy(app:)
    branch = "master"
    # branch = split repo, :branch # repo = "makevoid/mkdeploy:master" <|> "username/repo:branch"
    dir = DIR_APP % app
    ssh "git pull origin #{branch}", dir: dir
    restart app: app
  end

  def restart(app:)
    cmd = "touch tmp/restart.txt"
    dir = DIR_APP % app
    ssh cmd, dir: dir
  end

  def setup(app:)
    cmd = "bundle install"
    # cmd = "npm install" if APP_TYPE == :node
    dir = DIR_APP % app
    ssh cmd, dir: dir
  end

  def rake(app:)
    cmd = "rake"
    dir = DIR_APP % app
    ssh cmd, dir: dir
  end

  ##

  attr_reader :server, :connections

  def initialize(server:, connections:)
    @server       = server
    @connections  = connections
  end

  # include DBActionPlugin

  DB_TYPE = :mysql # FIXME: make dynamic type
  # choose from:
  #   - mysql
  #   - sqlite
  #   - sqlite + redis
  #
  #   w ROM

  def db_create
    DB_TYPE
  end

  def db_migrate
    # ruby lib/migrate.rb
  end

  # include ScreenshotPlugin

  def screen_shot
    # if OS.linux?
      # https://github.com/leonid-shevtsov/headless
    # else
      # response :OK, "", {}
  end

  def screen_capture_window
    # https://github.com/maxwell/screencap
  end

  private

  def app_language
    # TODO: detect app language - config.ru = ruby, package.json = html/node} - host node ones with nginx directive or mongrel2 (that has awesome configs)
  end

  def ssh(cmd, dir:)
    cd  = "cd #{dir} && " if dir
    cmd = "#{cd}#{cmd}"
    super cmd, server: server
  end

end
