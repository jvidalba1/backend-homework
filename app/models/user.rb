# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, format_email: true
  validates_uniqueness_of :email
  validates :password, format_password: true

  validates_presence_of :first_name, :last_name, :email
end
