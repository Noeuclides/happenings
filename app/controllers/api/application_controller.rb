class Api::ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  # Skip CSRF protection for API requests
  skip_before_action :verify_authenticity_token
end
