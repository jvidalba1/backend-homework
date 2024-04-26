class ApplicationController < ActionController::API
  def authorize_user
    auth_header = request.headers['HTTP_AUTHORIZATION']
    token = auth_header.split(' ')[1] if auth_header

    begin
      decoded = SessionTokenService.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :internal_server_error
    end
  end

  def current_user
    @current_user
  end
end
