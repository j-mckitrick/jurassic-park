class CagesController < ApplicationController
  before_filter :fetch_cage, :except => [:index, :create]

  def fetch_cage
    @cage = Cage.find_by_id(params[:id])
    Rails.logger.info "Dinos: #{@cage.dinosaurs.size}"
  end

  def show
    render json: @cage
  end

  def index
    Rails.logger.info "Index query #{params}"
    status = params[:status]
    if status && Set['active', 'down'].include?(status)
      render json: Cage.where(:power_status => status)
    else
      render json: Cage.all
    end
  end

  def list
    Rails.logger.info "List #{@cage}"
    render json: @cage.dinosaurs
  end
  
  def cage_params
    params.permit(:max_capacity, :power_status, :id)
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
    if @cage.update_attributes(cage_params) && @cage.valid?
      head :no_content, status: :ok
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end
end
