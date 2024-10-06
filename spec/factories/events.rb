# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  date           :datetime
#  description    :text
#  max_attendees  :integer
#  mode           :integer
#  name           :string
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("COP"), not null
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  organizer_id   :bigint           not null
#  venue_id       :bigint
#
# Indexes
#
#  index_events_on_organizer_id  (organizer_id)
#  index_events_on_venue_id      (venue_id)
#
# Foreign Keys
#
#  fk_rails_...  (organizer_id => users.id)
#  fk_rails_...  (venue_id => venues.id)
#
FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    organizer factory: :user
    venue { nil }
    date { "2024-09-28 12:22:59" }
    price { 11111 }
  end
end
