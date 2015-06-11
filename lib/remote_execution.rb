module RemoteExecution
  include Execution

  def metaclass
    ancestors.last
  end

  def ssh(cmd, server:, dir: nil)
    exe "ssh #{server} \"#{cmd}\"", dir: dir
  end
end
