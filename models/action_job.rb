class ActionJob
  include SuckerPunch::Job

  DEFAULT_SERVER = "makevoid@localhost"

  def perform(event:, repo:, server: DEFAULT_SERVER)
    # TODO: filter with TASKS or something similar
    Action.new(server: server).public_send event, repo: repo
  end

  # ActionJob.new.async.setup(repo: "mkdeploy")
  # ActionJob.new.async.deploy(repo: "mkdeploy")
  # ActionJob.new.async.restart(repo: "mkdeploy")

  # ActionJob.new.async.perform(event: "setup", repo: "mkdeploy")

end
