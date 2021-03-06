class AuthenticateUser
  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  # verify user credentials
  def user
    user = User.find_by(email:)
    #   return user if user && user.authenticate(password)
    return user if user&.valid_password?(password)
  end
end
