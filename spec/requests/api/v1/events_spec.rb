require 'swagger_helper'

RSpec.describe Api::V1::EventsController, type: :request do
  let(:user) { create(:user, :organizer) }
  let(:token) { JWT.encode({ sub: user.id }, Rails.application.credentials.devise_jwt_secret_key!) }
  let(:Authorization) { "Bearer #{token}" }

  path '/api/v1/events' do
    get 'Lists all events' do
      tags 'Events'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'events found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   date: { type: :string, format: :datetime },
                   price_cents: { type: :integer },
                   price_currency: { type: :string },
                   organizer_id: { type: :integer },
                   venue_id: { type: :integer, nullable: true },
                   status: { type: :string, enum: ['draft', 'published', 'cancelled'] },
                   mode: { type: :string, enum: ['on_site', 'online', 'both'] }
                 }
               }

        run_test!
      end
    end

    post 'Creates an event' do
      tags 'Events'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          date: { type: :string, format: :datetime },
          price: { type: :number },
          organizer_id: { type: :integer },
          venue_id: { type: :integer, nullable: true }
        },
        required: ['name', 'description', 'date', 'price', 'organizer_id']
      }

      response '201', 'event created' do
        let(:event) { { name: 'Test Event', description: 'Test Description', date: Time.now, price: 10.0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:event) { { name: 'Test Event' } }
        run_test!
      end
    end
  end

  path '/api/v1/events/{id}' do
    get 'Retrieves an event' do
      tags 'Events'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'event found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 date: { type: :string, format: :datetime },
                 price_cents: { type: :integer },
                 price_currency: { type: :string },
                 organizer_id: { type: :integer },
                 venue_id: { type: :integer, nullable: true },
                 status: { type: :string, enum: ['draft', 'published', 'cancelled'] },
                 mode: { type: :string, enum: ['on_site', 'online', 'both'] }
               }

        let(:id) { create(:event).id }
        run_test!
      end

      response '404', 'event not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates an event' do
      tags 'Events'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          date: { type: :string, format: :datetime },
          price: { type: :number },
          venue_id: { type: :integer, nullable: true }
        }
      }

      response '200', 'event updated' do
        let(:id) { create(:event, organizer: user).id }
        let(:event) { { name: 'Updated Event' } }
        run_test!
      end

      response '404', 'event not found' do
        let(:id) { 999 }
        let(:event) { { name: 'Updated Event' } }
        run_test!
      end
    end

    delete 'Deletes an event' do
      tags 'Events'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer

      response '204', 'event deleted' do
        let(:user) { create(:user, :admin) }
        let(:id) { create(:event, organizer: user).id }
        run_test!
      end

      response '404', 'event not found' do
        let(:id) { 999 }
        run_test!
      end
    end
  end
end