class AuthenticationService < ApplicationService
  include ActiveModel::Model

  attr_accessor :password, :email

  validates :password, format_password: true
  validates :email, format_email: true
  validates_presence_of :password, :email

  def initialize(email, password, token_service = SessionTokenService)
    @password = password
    @email = email
    @token_service = token_service
  end

  def call
    if valid?
      user = User.find_by(email: @email)

      if user && user.authenticate(@password)
        token = @token_service.encode({ user_id: user.id })
        return success({ user: user, token: token })
      else
        return failure('Incorrect email or password.', status: :unauthorized)
      end
    else
      return failure(errors.full_messages, status: :bad_request)
    end
  rescue JWT::EncodeError => e
    return failure(e.message, status: :internal_server_error)
  end
end
