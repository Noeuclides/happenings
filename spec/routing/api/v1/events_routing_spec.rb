require "rails_helper"

RSpec.describe Api::V1::EventsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/events").to route_to("api/v1/events#index")
    end

    it "routes to #new" do
      expect(get: "/api/v1/events/new").to route_to("api/v1/events#new")
    end

    it "routes to #show" do
      expect(get: "/api/v1/events/1").to route_to("api/v1/events#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/api/v1/events/1/edit").to route_to("api/v1/events#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/events").to route_to("api/v1/events#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/events/1").to route_to("api/v1/events#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/events/1").to route_to("api/v1/events#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/events/1").to route_to("api/v1/events#destroy", id: "1")
    end
  end
end
