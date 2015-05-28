APP_INSTS = [
  { host: :sys,  redis: 1, mysql: false }
  { host: :mkvd, redis: 1, mysql: true }
]

# AppInst = Qualcosa.deploy AppDef
# app = Qualcosa.deploy app: AppDef.new(antani: true), host: Host.new(:antani)


class AppInst

end

AppInstance = AppInst
