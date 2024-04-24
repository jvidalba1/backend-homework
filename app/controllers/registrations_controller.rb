class RegistrationsController < ApplicationController
  def create
    render json: { message: 'oelo' }, status: :ok
  end
end
