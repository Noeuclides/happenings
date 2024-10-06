require 'swagger_helper'

RSpec.describe 'Api::V1::SessionsController', type: :request do
  path '/api/v1/login' do
    post 'Logs in a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :login_params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        }
      }

      response '200', 'user logged in' do
        let!(:user) { create(:user, :confirmed) }
        let(:login_params) do
          {
            "user" => {
              "email" => user.email,
              "password" => user.password
            }
          }
        end

        run_test!
      end

      response '422', 'invalid credentials' do
        let(:login_params) do
          {
            user: {
              email: 'wrong@example.com',
              password: 'wrongpassword'
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/logout' do
    delete 'Logs out user' do
      tags 'Sessions'
      security [bearer_auth: []]

      response '200', 'logged out successfully' do
        let(:user) { create(:user, :confirmed) }
        let(:token) { generate_jwt_token(user) }
        let(:Authorization) { "Bearer #{token}" }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['status']).to eq(200)
          expect(data['message']).to eq('Logged out successfully.')
        end
      end

      # response '401', 'unauthorized' do
      #   let(:user) { create(:user, :confirmed) }
      #   let(:Authorization) { 'Bearer invalid_token' }
      #
      #   run_test! do |response|
      #     data = JSON.parse(response.body)
      #     expect(data['status']).to eq(401)
      #     expect(data['message']).to eq("Couldn't find an active session.")
      #   end
      # end
    end
  end
end