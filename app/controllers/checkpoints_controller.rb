class CheckpointsController < ApplicationController
  def index
    @checkpoint = Checkpoint.by_need(params[:need])
    @checkpoint = @checkpoint.by_neighborhood(params[:neighborhood]) if params[:neighborhood]

    render json: @checkpoint
  end

  def create
    Checkpoint.create(
      description: params[:description],
      neighborhood: params[:neighborhood],
      need: params[:need],
    )
  end
end
