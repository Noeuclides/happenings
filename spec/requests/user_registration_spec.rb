require 'rails_helper'
# require 'action_mailer'
#
# RSpec.describe 'UserRegistrations', type: :request do
#   describe 'POST /users' do
#     it 'creates a new user and sends a confirmation email' do
#       ActionMailer::Base.deliveries.clear
#
#       post user_registration_path, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } }
#
#       expect(response).to redirect_to(root_path)
#       expect(ActionMailer::Base.deliveries.size).to eq(1)
#       expect(ActionMailer::Base.deliveries.last.to).to include('test@example.com')
#     end
#   end
# end

RSpec.describe "UserRegistrations", type: :request do
  describe 'POST /users' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            first_name: 'Juan',
            last_name: 'Perez',
            email: 'juan@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end

      it 'creates a new user' do
        expect {
          post user_registration_path, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'creates a user with correct attributes' do
        post user_registration_path, params: valid_params
        user = User.last
        expect(user.first_name).to eq('Juan')
        expect(user.last_name).to eq('Perez')
        expect(user.email).to eq('juan@example.com')
      end

      it 'sends a confirmation email' do
        expect {
          post user_registration_path, params: valid_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'redirects to the root path' do
        post user_registration_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            first_name: '',
            last_name: '',
            email: 'invalid_email',
            password: 'short',
            password_confirmation: 'different'
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post user_registration_path, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'returns unprocessable entity status' do
        post user_registration_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end