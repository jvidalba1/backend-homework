class AuthenticationForm
  include ActiveModel::Model

  attr_accessor :password, :email

  validates :password, format_password: true
  validates :email, format_email: true
  validates_presence_of :password, :email
end
