class NeighborhoodsController < ApplicationController
  def show
    neighborhood = Neighborhoods.find(params[:id])

    render json: neighborhood
  end
end
