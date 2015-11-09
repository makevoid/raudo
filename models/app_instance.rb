APP_INSTS = [
  { host: :sys,  redis: 1, mysql: false },
  { host: :mkvd, redis: 1, mysql: true },
]

# AppInst = Qualcosa.deploy AppDef
# app = Qualcosa.deploy app: AppDef.new(antani: true), host: Host.new(:antani)


Transproc.register :to_json, -> v { JSON.dump v }

class AppInstance
  include RemoteExecution

  require 'transproc/all'
  include Transproc::Helper

  WWW_PATH = "/www"

  DEFAULT_HOST = Conf::DEFAULT_HOST

  def self.all(server=DEFAULT_HOST)
    new.all(server)
  end

  def all(server)
    out = ssh "ls #{WWW_PATH}", server: server
    namize split out
  end

  def clone(server=DEFAULT_HOST)
    # TODO: not used?
    #
    # ssh "git clone https://github.com/makevoid/mkdeploy", server: server
  end

  private

  def namize(array)
    t_hash_name = -> value do
      { name: value }
    end
    t_mash = -> hash { Hashie::Mash.new hash }
    proc = t(:map_array, t_hash_name) >> t(:map_array, t_mash)
    proc.(array)
  end

  def split(list)
    list.split "\n"
  end

end

# AppInst = AppInstance
# App     = AppInstance
