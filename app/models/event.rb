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
class Event < ApplicationRecord
  belongs_to :organizer, class_name: User.name
  belongs_to :venue, optional: true
  has_many :registrations
  has_many :users, through: :registrations

  monetize :price_cents

  enum status: { draft: 0, published: 1, cancelled: 2 }
  enum mode: { on_site: 0, online: 1, both: 2 }, _default: :on_site

  has_one_attached :image

  validates :name, :description, :date, presence: true
end
