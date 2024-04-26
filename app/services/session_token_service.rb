class SessionTokenService

  SECRET_KEY = Rails.application.credentials.secret_key_base
  EXPIRATION_TIME = 20.minutes.from_now

  def self.encode(payload)
    payload[:exp] = EXPIRATION_TIME.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
