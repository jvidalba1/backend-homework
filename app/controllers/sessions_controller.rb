class SessionsController < ApplicationController
  def create
    auth_form = AuthenticationForm.new(email: session_params[:email], password: session_params[:password])

    if auth_form.valid?
      user = User.find_by(email: session_params[:email])

      if user && user.authenticate(session_params[:password])
        token = SessionTokenService.new(user.email).encode
        render json: {
          data: {
            user: {
              first_name: user.first_name,
              last_name: user.last_name,
              email: user.email,
              token: token
            }
          }
        }, status: :ok
      else
        render json: { data: { errors: 'Incorrect email or password.' } }, status: :not_found
      end
    else
      render json: { data: { errors: auth_form.errors.full_messages } }, status: :bad_request
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
