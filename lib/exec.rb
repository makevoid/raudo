module Execution
  def exec(cmd)
    puts "executing: #{cmd}"
    out = `#{cmd}`
    puts out
    puts
    out
  end
end
