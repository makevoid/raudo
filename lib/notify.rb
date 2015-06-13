module Notify
  def notify(action)
    connections.each do |out|
      out << "data: #{action}\n\n"
    end
  end
end
