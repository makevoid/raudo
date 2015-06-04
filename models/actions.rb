class Action
  include RemoteExecution

  DIR_APP    = "/www/%s"        # usage: APP_DIR % "raudo"
  DIR_PUBLIC = "/www/%s/public" # usage: DIR_PUBLIC % "antani"

  def deploy
    # cmd_cd    = "cd /path/#{dir}"
    # cmd_main  = "asdasd #{}"
    # cmd       = "#{cmd_cd};{cmd_main}"
    # ssh cmd
    # cd dir
  end

  def restart
    dir = "/www"
    cmd = "touch tmp/restart"
    ssh cmd, dir: dir
  end

  def setup

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

  private

  def app_language
    # TODO: detect app language - config.ru = ruby, package.json = html/node} - host node ones with nginx directive or mongrel2 (that has awesome configs)
  end

end
