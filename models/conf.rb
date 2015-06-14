class Conf
  DIR_APPS = "/www"

  DEFAULT_HOST = if ENV["RACK_ENV"] == "development"
    # "makevoid@localhost"
    "francescocanessa@localhost"
  else
    "www@sys.makevoid.com"
  end

  if defined? DEV_USERNAME
    if DEV_USERNAME == "45kb"
      DEFAULT_HOST = "45kb@localhost"
      WWW_PATH     = "#{PATH}/www"
    end
  end
end
