module ValidatorsHelpers
  class FakeFormatPasswordValidable
    include ActiveModel::Validations
    attr_accessor :password
    validates :password, format_password: true
  end

  class FakeFormatEmailValidable
    include ActiveModel::Validations
    attr_accessor :email
    validates :email, format_email: true
  end
end
