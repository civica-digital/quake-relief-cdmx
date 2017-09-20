require 'twitter_scanner'

class TwitterRemover
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(*args)
    TwitterScanner.remove_obsolete
  end
end
