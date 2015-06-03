module Execution
  def exe(cmd, dir: nil)
    puts "executing: #{cmd}"
    cd  = "cd #{dir};" if cd
    out = `#{cd}#{cmd}`
    puts out
    puts
    out
  end
end
