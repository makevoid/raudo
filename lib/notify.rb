module Notify
  def notify(action)
    EventStream.new << action
  end
end
