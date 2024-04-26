class SessionsController < ApplicationController
  def create
    authentication = AuthenticationService.new(session_params[:email], session_params[:password]).call

    if authentication.success?
      render json: { data: authentication.payload }, status: authentication.status
    else
      render json: { errors: authentication.errors }, status: authentication.status
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
