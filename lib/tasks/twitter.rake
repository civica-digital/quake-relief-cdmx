namespace :twitter do
  desc "Scans all Twitter hashtags and saves tweets into database"
  task scan: :environment do
    TwitterWorker.perform_async()
  end

end
