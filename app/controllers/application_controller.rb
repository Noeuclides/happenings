class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :reset_api_request

  rescue_from ActionPolicy::Unauthorized do |ex|
    # ex.policy, ex.rule
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_url, flash: {error: ex.message} }
      format.js { head :forbidden, content_type: "text/html" }
    end
  end

  private
  # def reset_api_request
  #   User.api_request = false
  # end
end
