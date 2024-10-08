require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/events", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  # let(:user) { create(:user, :confirmed, role: :organizer) }
  let(:valid_attributes) {
    { name: "event1", description: 'descrption', date: Time.now, organizer: user, venue: create(:venue) }
  }

  let(:invalid_attributes) {
    { organizer: user }
  }

  describe "GET /index" do

    context 'when user is organizer' do
      include_context :login_user, role: :organizer

      it "renders a successful response" do
        Event.create! valid_attributes

        get events_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /show" do
    include_context :login_user, role: :organizer

    it "renders a successful response" do
      event = Event.create! valid_attributes
      get event_url(event)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    context 'when user is organizer' do
      include_context :login_user, role: :organizer

      it "renders a successful response" do
        get new_event_url
        expect(response).to be_successful
      end
    end

    context 'when user is assistant' do
      include_context :login_user, role: :assistant

      it "redirects to root_path" do
        get new_event_url
        # expect(response).to be_successful
        expect(response).to redirect_to(root_path)
        # expect(response).to render_template(:new)
      end
    end
  end

  describe "GET /edit" do
    include_context :login_user, role: :organizer

    it "renders a successful response" do
      event = Event.create! valid_attributes
      get edit_event_url(event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    include_context :login_user, role: :organizer

    context "with valid parameters" do
      it "creates a new Event" do
        expect {
          post events_url, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post events_url, params: { event: valid_attributes }
        expect(response).to redirect_to(event_url(Event.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect {
          post events_url, params: { event: invalid_attributes }
        }.to change(Event, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post events_url, params: { event: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

    context "when an user is not authorized" do
      include_context :login_user, role: :assistant

      it "redirects to root_path" do
        post events_url, params: { event: invalid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      include_context :login_user, role: :organizer

      let(:new_attributes) {
        { name: 'new name' }
      }

      it "updates the requested event" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(event.name).to eq(new_attributes[:name])
      end

      it "redirects to the event" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(response).to redirect_to(event_url(event))
      end
    end

    context "with invalid parameters" do
      include_context :login_user, role: :organizer

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when an user is not authorized" do
      include_context :login_user, role: :assistant

      it "redirects to root_path" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: invalid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /destroy" do
    include_context :login_user, role: :organizer

    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete event_url(event)
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete event_url(event)
      expect(response).to redirect_to(events_url)
    end
  end
end
