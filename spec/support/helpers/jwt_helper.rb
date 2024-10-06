module JwtHelper
  def generate_jwt_token(user)
    JWT.encode(
      {
        sub: user.id,
        jti: user.jti,
        scp: 'user',
        aud: 'happenings',
        exp: 24.hours.from_now.to_i
      },
      Rails.application.credentials.devise_jwt_secret_key!
    )
  end
end