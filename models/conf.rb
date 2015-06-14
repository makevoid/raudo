class Conf
  DIR_APPS = "/www"
  # DEFAULT_HOST = "root@makevoid.com"
  DEFAULT_HOST = "francescocanessa@localhost"
  # DEFAULT_HOST = "makevoid@localhost"

  if defined? DEV_USERNAME
    if DEV_USERNAME == "45kb"
      DEFAULT_HOST = "45kb@localhost"
      WWW_PATH     = "#{PATH}/www"
    end
  end
end
