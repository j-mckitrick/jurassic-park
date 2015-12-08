class CagesController < ApplicationController
  before_filter :fetch_cage, :except => [:index, :create]

  def fetch_cage
    @cage = Cage.find_by_id(params[:id])
  end

  def show
    render json: @cage
  end

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
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  def update
    Rails.logger.info "Found cage to update #{@cage}"
    if @cage.update_attributes(cage_params)
      head :no_content, status: :ok
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end
end
