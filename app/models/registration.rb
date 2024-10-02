# == Schema Information
#
# Table name: registrations
#
#  id         :bigint           not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_registrations_on_event_id              (event_id)
#  index_registrations_on_user_id               (user_id)
#  index_registrations_on_user_id_and_event_id  (user_id,event_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { pending: 0, confirmed: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :event_id, message: "Ya estás registrado en este evento" }
end
