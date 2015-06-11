class ActionJob
  include SuckerPunch::Job

  DEFAULT_SERVER = "makevoid@localhost"

  def perform(event:, app:, server: DEFAULT_SERVER)
    # TODO: filter with TASKS or something similar
    Action.new(server: server).public_send event, app: app
  end

  # ActionJob.new.async.setup(app: "mkdeploy")
  # ActionJob.new.async.deploy(app: "mkdeploy")
  # ActionJob.new.async.restart(app: "mkdeploy")

  # ActionJob.new.async.perform(event: "setup", app: "mkdeploy")

end
