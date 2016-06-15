require_relative "conf"

class Creation
  include RemoteExecution
  include Notify

  DIR_APPS   = Conf::DIR_APPS

  attr_reader :server

  def initialize(server:)
    @server       = server
  end

  def create(app)
    # username = "makevoid"
    ssh "cd #{DIR_APPS} && git clone https://github.com/#{app}", server: server
  end

end
