class RandomsController < ApplicationController
  def index
    random_number = RandomNumberService.new(params[:min], params[:max]).call

    if random_number.success?
      render json: { random_number: random_number.payload }, status: :ok
    else
      render json: { errors: random_number.errors }, status: :internal_server_error
    end
  end
end
