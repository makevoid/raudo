require 'mina/bundler'
require 'mina/git'

# configs
app_name = "raudo"

set :domain,      'sys.makevoid.com'
set :deploy_to,   "/www/#{app_name}"
set :repository,  "git://github.com/makevoid/#{app_name}"
set :branch,      'master'

set :shared_paths, ['log']

set :user, 'www'

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
end

desc "Main deployment task"
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    to :launch do
      # todo: move into its own task
      queue 'bower install'

      queue 'mkdir -p tmp'
      queue 'touch tmp/restart.txt'
    end
  end
end
