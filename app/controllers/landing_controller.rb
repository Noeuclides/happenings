class LandingController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_signed_in

  def index
  end

  private

  def check_signed_in
    redirect_to home_path if signed_in?
  end
end
