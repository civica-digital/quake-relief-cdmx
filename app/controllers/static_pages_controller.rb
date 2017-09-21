class StaticPagesController < ApplicationController
  def index
    @status_options = ['Todas', 'Condesa', 'Del Valle', 'Roma', 'Doctores']
    @counters = TweetsAndSupportersCounter.top_needs(6)
  end
end

