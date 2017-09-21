class StaticPagesController < ApplicationController
  def index
    @counters = TweetsAndSupportersCounter.top_needs(6)
  end
end

