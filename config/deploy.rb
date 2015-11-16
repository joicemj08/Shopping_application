# config valid only for current version of Capistrano
lock '3.4.0'

# Define the name of the application
set :application, 'Quick_Deals'

# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/[user name]/[application name].git'
set :scm, :git
set :repo_url, 'https://github.com/joicemj08/Shopping_application.git'


# Define where to put your application code
set :deploy_to, "/home/deployer/apps/my_app"

set :pty, true

set :format, :pretty

# Set the post-deployment instructions here.
# Once the deployment is complete, Capistrano
# will begin performing them as described.
# To learn more about creating tasks,
# check out:
# http://capistranorb.com/
set :rvm_ruby_version, '2.2.1'
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
SSHKit.config.command_map[:rake] = "#{fetch(:default_env)[:rvm_bin_path]}/rvm ruby-#{fetch(:rvm_ruby_version)} do bundle exec rake"
namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
       execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart


  desc 'precompiling assets..............'
  task :precompile_assets do
    on roles(:web) do
      within release_path do
        execute :rake, "assets:clobber RAILS_ENV=production"
        execute :rake, "assets:precompile RAILS_ENV=production"
      end
    end
  end

  desc "Upload database.yml file."
  task :upload_secrets do
    on roles(:app) do
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  task :uptime do
    on roles(:demo), in: :parallel do |host|
      uptime = capture(:uptime)
      puts "#{host.hostname} reports: #{uptime}"
    end
  end
  after :publishing, 'deploy:precompile_assets'

end
