class DinosaursController < ApplicationController
  before_filter :fetch_dinosaur, :except => [:index, :create]

  def fetch_dinosaur
    @dinosaur = Dinosaur.find_by_id(params[:id])
  end

  def show
    render json: @dinosaur
  end

  def index
    species = params[:species]
    if species && species != ''
      render json: Dinosaur.where(:species => species)
    else
      render json: Dinosaur.all
    end
  end

  def dinosaur_params
    params.permit(:name, :species, :classification, :cage_id, :id)
  end

  def create
    @dinosaur = Dinosaur.new(dinosaur_params)

    if @dinosaur.save
      render json: @dinosaur, status: :created
    else
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  def update
    Rails.logger.info "Found dinosaur to update #{@dinosaur}"
    if @dinosaur.update_attributes(dinosaur_params) && @dinosaur.valid?
      head :no_content, status: :ok
    else
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end
end
