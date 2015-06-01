APP_INSTS = [
  { host: :sys,  redis: 1, mysql: false },
  { host: :mkvd, redis: 1, mysql: true },
]

# AppInst = Qualcosa.deploy AppDef
# app = Qualcosa.deploy app: AppDef.new(antani: true), host: Host.new(:antani)


module CmdUtils
  def ssh(cmd, server:)
    `ssh #{server} #{cmd}`
  end
end

class AppInst
  extend CmdUtils

  def self.all
    server = "root@makevoid.com"
    ssh "ls", server: server
  end
end

AppInstance = AppInst
