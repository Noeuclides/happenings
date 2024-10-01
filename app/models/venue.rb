# == Schema Information
#
# Table name: venues
#
#  id            :bigint           not null, primary key
#  address       :string
#  capacity      :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :bigint           not null
#
# Indexes
#
#  index_venues_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
class Venue < ApplicationRecord
  belongs_to :created_by, class_name: User.name

  validates :name, :address, :capacity, presence: true

end
