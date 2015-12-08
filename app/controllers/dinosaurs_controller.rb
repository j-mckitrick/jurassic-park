class DinosaursController < ApplicationController
  def index
    render json: Dinosaur.all
  end

  def dinosaur_params
    params.permit(:name, :species, :classification, :cage)
  end

  def create
    @dinosaur = Dinosaur.new(dinosaur_params)

    if @dinosaur.save
      render json: @dinosaur, status: :created
    else
      render json: @dinosaur, status: :unprocessable_entity
    end
  end
end
