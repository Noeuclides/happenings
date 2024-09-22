require 'rails_helper'

RSpec.describe 'UserConfirmations', type: :request do
  let(:user) { create(:user, :pending) }

  describe 'GET /users/confirmation' do
    it 'confirms the user and redirects to the sign-in page' do
      token = user.confirmation_token
      get user_confirmation_path(confirmation_token: token)

      user.reload
      expect(user.confirmed?).to be true
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
