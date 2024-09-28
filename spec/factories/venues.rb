# == Schema Information
#
# Table name: venues
#
#  id            :bigint           not null, primary key
#  address       :string
#  capacity      :integer
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
FactoryBot.define do
  factory :venue do
    address { "MyString" }
    capacity { 1 }
    created_by { nil }
  end
end
