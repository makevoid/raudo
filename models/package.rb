class Package

  def install(name)
    `apt-get install #{name} -y`
  end

end
