class ActionJob
  include SuckerPunch::Job

  DEFAULT_HOST = Conf::DEFAULT_HOST

  def perform(event:, app:, connections:, server: DEFAULT_HOST)
    # TODO: filter with TASKS or something similar
    action = Action.new(server: server, connections: connections)
    action.public_send event, app: app
    action.notify event
  end

  # ActionJob.new.async.setup(app: "mkdeploy")
  # ActionJob.new.async.deploy(app: "mkdeploy")
  # ActionJob.new.async.restart(app: "mkdeploy")

  # ActionJob.new.async.perform(event: "setup", app: "mkdeploy")

end
