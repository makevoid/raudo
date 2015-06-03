module RemoteExecution
  include Execution

  def metaclass
    ancestors.last
  end

  def ssh(cmd, server:)
    exe "ssh #{server} #{cmd}"
  end
end
