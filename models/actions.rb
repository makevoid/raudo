# usage:
#
# Action.new.setup

class Action
  include RemoteExecution

  DIR_APPS   = "/www"
  DIR_APP    = "/www/%s"        # usage: APP_DIR % "raudo"
  DIR_PUBLIC = "/www/%s/public" # usage: DIR_PUBLIC % "antani"

  # TASKS = %w(deploy restart setup db_create db_migrate)

  def deploy
    branch = "master"
    # branch = split repo, :branch # repo = "makevoid/mkdeploy:master" <|> "username/repo:branch"
    ssh "git pull origin #{branch}"

    restart
    puts "deploy finished"
  end

  def restart(app:)
    cmd = "touch tmp/restart.txt"
    ssh cmd, dir: DIR_APPS
  end

  def setup(app:)
    ssh "mkdir -p #{DIR_APPS}", server: server
    ssh "git clone https://github.com/makevoid/#{app}", dir: DIR_APPS, server: server
  end

  ##

  attr_reader :server

  def initialize(server:)
    @server = server
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

  end

  # include ScreenshotPlugin

  def screen_shot
    # if OS.linux?
      # https://github.com/leonid-shevtsov/headless
    # else
      # response :OK, "", {}
  end

  def screen_capture_window

  end

  private

  def app_language
    # TODO: detect app language - config.ru = ruby, package.json = html/node} - host node ones with nginx directive or mongrel2 (that has awesome configs)
  end

  def ssh(cmd, dir:)
    super cmd, server: server, dir: dir
  end

end
