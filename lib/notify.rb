module Notify
  def notify(action)
    EventStream.instance << action
  end
end
