module JwtAuthenticable
  extend ActiveSupport::Concern

  included do
    rescue_from JWT::DecodeError, with: :invalid_token
    rescue_from JWT::ExpiredSignature, with: :expired_token

    def invalid_token
      render json: { errors: 'invalid_token' }, status: :unauthorized
    end

    def expired_token
      render json: { errors: 'expired_token' }, status: :unauthorized
    end
  end
end

