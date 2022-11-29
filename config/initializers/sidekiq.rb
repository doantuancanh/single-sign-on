Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/1') }
end
# require Rails.root.join('lib/redis/config')

# Sidekiq.configure_client do |config|
#   config.redis = Redis::Config.app
# end

# Sidekiq.configure_server do |config|
#   config.redis = Redis::Config.app
#   config.logger.level = Logger.const_get(ENV.fetch('LOG_LEVEL', 'info').upcase.to_s)
# end

# # https://github.com/ondrejbartas/sidekiq-cron
# Rails.application.reloader.to_prepare do
#   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
# end
