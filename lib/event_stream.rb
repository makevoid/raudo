class EventStream

  def self.instance
    @@instance ||= EventStream.new
  end

  def <<(message)
    R.lpush "messages", message
  end

  def each
    # loop do
    100.times do
      # EM.add_periodic_timer(1) do <--- doesn't seem to work under Passenger
      messages_length = R.llen "messages"
      if messages_length > 0
        messages_length.times do
          mex = R.lpop "messages"
          mex = format mex
          yield mex
        end
      end

      sleep 0.2
    end
  end

  private

  def format(message)
    "data: #{message}\n\n"
  end

end
