class Task

  H = Hashie::Mash

  def self.all
    H.new(
      main: %w(
        deploy
        restart
        setup
        rake
      ),
      sub:  H.new(
        db: %w(),
        monitoring: %w(),
      ),
      # sub:  H.new(
      #   db: %w(
      #     create
      #     migrate
      #   ),
      #   monitoring: %w(
      #     screenshot
      #     logs
      #     munin
      #   ),
      # ),
    )
  end

end
