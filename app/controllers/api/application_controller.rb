class Api::ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  # Skip CSRF protection for API requests
  # skip_before_action :verify_authenticity_token
  before_action :set_api_request

  private

  def set_api_request
    User.api_request = true
  end
end
