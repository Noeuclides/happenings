json.extract! event, :id, :name, :description, :organizer_id, :venue_id, :date, :price, :created_at, :updated_at
json.url event_url(event, format: :json)
