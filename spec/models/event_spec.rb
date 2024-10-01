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
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
