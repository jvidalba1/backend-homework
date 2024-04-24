class SessionTokenService
  def initialize(email)
    @email = email
  end

  def encode
    "ABC#{@email}1234"
  end
end
