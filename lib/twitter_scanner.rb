require 'twitter'

module TwitterScanner

  def self.scan(keywords)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end

    tweets = []
    client.search(keywords, result_type: "recent").collect do |tweet|
      next if Tweet.find_by_twitter_id(tweet.id).present?
      t = Tweet.new(
        twitter_id: tweet.id,
        author: tweet.user.screen_name,
        text: tweet.text,
        url: tweet.uri,
        created_at: tweet.created_at
      )
      if tweet.geo.coords.present?
        t.lat = tweet.geo.coords[0]
        t.lng = tweet.geo.coords[1]
      end
      t.save
    end
  end

  def self.remove_obsolete
    Tweet.where("created_at < ?", 12.hours.ago).delete_all
  end

end
