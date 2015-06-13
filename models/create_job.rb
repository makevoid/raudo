class CreateJob
  include SuckerPunch::Job

  DEFAULT_SERVER = "francescocanessa@localhost"

  def perform(app:, connections:, server: DEFAULT_SERVER)
    creation = Creation.new(server: server, connections: connections)
    creation.create app
    creation.notify "create_app-#{app}"
  end

end
