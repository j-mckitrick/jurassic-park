class CagesController < ApplicationController
  def index
    render json: Cage.all
  end

  def cage_params
    params.permit(:max_capacity, :current_count, :power_status)
  end

  def create
    @cage = Cage.new(cage_params)

    if @cage.save
      render json: @cage, status: :created
    else
      render json: @cage, status: :unprocessable_entity
    end
  end
end
