module Execution
  def exe(cmd, dir: nil)
    puts "executing: #{cmd}"
    out = `#{cmd}`
    puts out
    puts
    out
  end
end
