class RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      # ToDo: Add serializations to json responses
      render json: { data: { user: user } }, status: :created
    else
      render json: { data: { errors: user.errors.full_messages } }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :birthday)
  end
end
