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
      next if Tweet.find_by_twitter_id(tweet.id).present?
      t = Tweet.new(
        twitter_id: tweet.id,
        author: tweet.user.screen_name,
        text: tweet.text,
        url: tweet.uri,
        created_at: tweet.created_at
      )
      tweet_text = t.text.downcase

      needs = self.extract_needs(tweet_text)
      next if needs.blank?
      neighborhood = self.extract_neighborhood(tweet_text)
      next if neighborhood.blank?

      self.update_tweets_counter(needs, neighborhood)

      # Categorize needs and neighborhood
      t.neighborhood = neighborhood
      t.needs = needs

      t.save
    end
  end

  def self.remove_obsolete
    Tweet.where("created_at < ?", 2.hours.ago).delete_all
  end

  def self.extract_needs(text)
    raise ArgumentError, 'missing text' unless text

    result = []

    Needs.all.each do |need|
      if need.is_a?(Hash)
        key = need.keys.first
        collection = need.first.flatten
        result << key if collection.map { |x| text.include?(x) }.reduce(:|)
        next
      end

      result << need if text.include?(need)
    end

    result
  end

  def self.extract_neighborhood(text)
    raise ArgumentError, 'missing text' unless text

    Neighborhoods.all.each do |neighborhood|

      if neighborhood.is_a?(Hash)
        key = neighborhood.keys.first
        collection = neighborhood.first.flatten
        return key if collection.map { |x| text.include?(x) }.reduce(:|)
        next
      end

      return neighborhood if text.include?(neighborhood)
    end

    nil
  end

  def self.update_tweets_counter(needs, neighborhood)
    needs.each do |need|
      counter = TweetsAndSupportersCounter.find_or_create_by(
        need: need,
        neighborhood: neighborhood,
      )

      counter.increment(:tweets_count).save
    end
  end

  def self.categorize_needs_and_neighborhood(tweet, needs, neighborhood)
  end

  def self.update_database
    Tweet.find_each(batch_size: 100) do |t|
      tweet_text = t.text.downcase

      needs = self.extract_needs(tweet_text)
      next if needs.blank?
      neighborhood = self.extract_neighborhood(tweet_text)
      next if neighborhood.blank?

      self.update_tweets_counter(needs, neighborhood)
    end
  end
end
