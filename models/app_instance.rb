APP_INSTS = [
  { host: :sys,  redis: 1, mysql: false },
  { host: :mkvd, redis: 1, mysql: true },
]

# AppInst = Qualcosa.deploy AppDef
# app = Qualcosa.deploy app: AppDef.new(antani: true), host: Host.new(:antani)




Transproc.register :to_json, -> v { JSON.dump v }

class AppInstance
  extend RemoteExecution

  require 'transproc/all'
  include Transproc::Helper

  # DEFAULT_HOST = "root@makevoid.com"
  DEFAULT_HOST = "makevoid@localhost"

  def self.all(server=DEFAULT_HOST)
    new.all(server)
  end

  def all(server)
    out = ssh "ls", server: server
    namize split out
  end

  def clone(server=DEFAULT_HOST)
    ssh "git clone https://github.com/makevoid/mkdeploy", server: server
  end

  private

  def self.namize(array)
    proc = t(:map_array, -> value { { name: value } })
    list = proc.(array)

    list = Hash[*list]

    proc = t(:map_array, -> value { { name: value } })
    t(proc).(list)
  end

  def self.split(list)
    list.split "\n"
  end

end

# AppInst = AppInstance
# App     = AppInstance
