class Action
  include RemoteExecution

  DIR_APP    = "/www/%s"        # usage: APP_DIR % "raudo"
  DIR_PUBLIC = "/www/%s/public" # usage: DIR_PUBLIC % "antani"

  def deploy
    branch = "master"
    # branch = split repo, :branch # repo = "makevoid/mkdeploy:master" <|> "username/repo:branch"
    ssh "git pull origin #{branch}"

    restart
    puts "deploy finished"
  end

  def restart
    cmd = "touch tmp/restart"
    ssh cmd, dir: DIR_APP
  end

  def setup
    ssh "mkdir -p #{DIR_APP}"
    ssh "git clone https://github.com/makevoid/#{repo}", dir: DIR_APP
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

end
