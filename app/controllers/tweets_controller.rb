class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @tweets = Tweet.search_by_keywords(:need)
    filter :by_need, :need
    filter :by_neighborhood, :neighborhood
  end

  si no viene neighborhood (todas) limit 2

  condesa
    - saonethu
    - snaotehu
    - snatoehu

  search = [ ]
  Tweet.search_by_keyword('santoh')
  return search if search.size? 2
  Tweet.search_by_snatoehu
end
