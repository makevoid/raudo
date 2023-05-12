class Conf
  DIR_APPS = "/www"

  HOST_CONF   = "#{PATH}/config/host.txt"
  LOADED_HOST = if File.exist? HOST_CONF
    File.read(HOST_CONF).strip
  end

  DEFAULT_HOST = if APP_ENV == "development"
    "makevoid@localhost"
  else
    LOADED_HOST || "www@sys.makevoid.com"
  end

  if defined? DEV_USERNAME
    if DEV_USERNAME == "45kb"
      DEFAULT_HOST = "45kb@localhost"
      WWW_PATH     = "#{PATH}/www"
    end
  end
end
