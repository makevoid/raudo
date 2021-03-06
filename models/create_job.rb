class CreateJob
  include SuckerPunch::Job

  DEFAULT_HOST = Conf::DEFAULT_HOST

  def perform(app:, server: DEFAULT_HOST)
    creation = Creation.new server: server 
    creation.create app
    creation.notify "create_app-#{app}"
  end

end
