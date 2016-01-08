require_relative "conf"

class Creation
  include RemoteExecution
  include Notify

  DIR_APPS   = Conf::DIR_APPS

  attr_reader :server, :connections

  def initialize(server:, connections:)
    @server       = server
    @connections  = connections
  end

  def create(app)
    # username = "makevoid"
    ssh "cd #{DIR_APPS} && git clone https://github.com/#{app}", server: server
  end

end
