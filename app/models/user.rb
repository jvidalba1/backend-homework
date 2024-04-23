# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#?\]])(?=.*[\W]).{10,}\z/

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates_format_of :password, with: PASSWORD_REGEX
end
