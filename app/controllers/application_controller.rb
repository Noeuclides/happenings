class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from ActionPolicy::Unauthorized do |ex|
    # ex.policy, ex.rule
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_url, flash: {error: ex.message} }
      format.js { head :forbidden, content_type: "text/html" }
    end
  end
end
