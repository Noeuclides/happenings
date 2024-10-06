class Api::ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionPolicy::Controller
  include JwtAuthenticable
  authorize :user, through: :current_user
  respond_to :json

  # Skip CSRF protection for API requests
  # skip_before_action :verify_authenticity_token
  # before_action :set_api_request

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: "#{e.model} not found" }, status: :not_found
  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    if header.present?
      jwt_payload = JWT.decode(header.split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      @current_user = User.find(jwt_payload['sub'])
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  # def set_api_request
  #   User.api_request = true
  # end
end
