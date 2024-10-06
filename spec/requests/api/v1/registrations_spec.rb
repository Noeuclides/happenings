require 'swagger_helper'

RSpec.describe 'Api::V1::RegistrationsController', type: :request do
  path '/api/v1/signup' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string }
            },
            required: %w[email password first_name last_name]
          }
        }
      }

      response '200', 'user created' do
        let(:user) do
          {
            user: {
              email: Faker::Internet.email,
              password: 'password123',
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name
            }
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) do
          {
            user: {
              email: 'invalid_email',
              password: 'short',
              first_name: '',
              last_name: ''
            }
          }
        end
        run_test!
      end
    end
  end
end