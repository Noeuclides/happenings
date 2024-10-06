class Api::V1::SessionsController < Devise::SessionsController
  include JwtAuthenticable
  respond_to :json

  protect_from_forgery with: :null_session
  skip_before_action :verify_signed_out_user, only: :destroy
  skip_before_action :verify_authenticity_token
  skip_before_action :require_no_authentication

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }
  end

  def respond_to_on_destroy
    jwt_token = request.headers['Authorization']&.split(' ')&.last

    if jwt_token
      begin
        jwt_payload = JWT.decode(jwt_token, Rails.application.credentials.devise_jwt_secret_key!).first
        current_user = User.find(jwt_payload['sub'])
        current_user.update(jti: SecureRandom.uuid)

        render json: {
          status: 200,
          message: 'Logged out successfully.'
        }, status: :ok
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: {
          status: 401,
          message: "Couldn't find an active session."
        }, status: :unauthorized
      end
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end