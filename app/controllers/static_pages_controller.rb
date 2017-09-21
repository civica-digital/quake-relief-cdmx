class StaticPagesController < ApplicationController
  def index
    @status_options = ['Todas', 'Condesa', 'Del Valle', 'Roma', 'Doctores']
    @counters = TweetsAndSupportersCounter.top_needs(6)

    if params[:need].present? && params[:need
      @users = @users.with_text(params[:search_text][:text])
      respond_to do |format|
          format.js
      end
    end
  end
end

