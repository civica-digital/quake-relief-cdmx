require 'twitter'

module TwitterScanner

  def self.scan(keywords)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end

    client.search(keywords, result_type: "recent").collect do |tweet|
      puts "#{tweet.user.screen_name}: #{tweet.text}"
    end
  end

end
