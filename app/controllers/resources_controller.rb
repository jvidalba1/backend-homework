class ResourcesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :access_denied
  before_action :authorize_user

  def not_found
    render json: { errors: 'Not found error' }, status: :not_found
  end

  def access_denied
    render json: { errors: 'You are not authorized for this action.' }, status: :unauthorized
  end
end
