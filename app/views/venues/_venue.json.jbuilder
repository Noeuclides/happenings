json.extract! venue, :id, :address, :capacity, :created_by_id, :created_at, :updated_at
json.url venue_url(venue, format: :json)
