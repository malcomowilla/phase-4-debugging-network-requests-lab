class ToysController < ApplicationController
  wrap_parameters format: []
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update(toy_params)
    render json: toy
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def unprocessable_entity_response(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

  def record_not_found_response
    render json: {errors: "toy not found"}, status: :not_found
  end
end
