class StaticPagesController < ApplicationController
  def index
    @status_options = ['Todas'] + Neighborhoods.all_keys
    @needs_counters = TweetsAndSupportersCounter.top_needs(6)
    @supporters_counters = TweetsAndSupportersCounter.top_supporters(6)

    @neighborhood = params[:neighborhood]

    if @neighborhood && @neighborhood != 'todas'
      @needs_counters = @needs_counters.by_neighborhood(@neighborhood)
      @supporters_counters = @supporters_counters.by_neighborhood(@neighborhood)
    end
  end

  def modal
    @counter = TweetsAndSupportersCounter.find(params[:counter_id])
    @neighborhood = params[:neighborhood]

    # @checkpoints = Checkpoint.by_need(@need)
    # @checkpoints = @checkpoint.by_neighborhood(@neighborhood) if @neighborhood && @neighborhood != 'todas'

    @tweets = tweets_json(@neighborhood, @counter.need)

    respond_to do |format|
      format.js
    end
  end

  def tweets_json(neighborhood, need)
    tweets = Tweet.by_need(need).limit(2)
    tweets = tweets.by_neighborhood(neighborhood) if neighborhood && neighborhood != 'todas'

    tweets
    # tweets.map do |tweet|
    #   JSON.parse(RestClient.get("https://publish.twitter.com/oembed?url=#{tweet.url}").body)
    # end
  end
end

