class CagesController < ApplicationController
  def index
    render json: Cage.all
  end
end
