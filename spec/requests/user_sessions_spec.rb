require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  let(:user) { create(:user, :confirmed) }

  describe 'POST /users/sign_in' do
    it 'signs in the user and redirects to the root path' do
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      follow_redirect!

      expect(response).to redirect_to(home_path)
      expect(controller.current_user).to eq(user)
    end
  end
end
