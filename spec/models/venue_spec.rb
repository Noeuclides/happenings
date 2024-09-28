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
require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe "fields" do
    it { should have_db_column(:address).of_type(:string) }
    it { should have_db_column(:capacity).of_type(:integer) }
  end

  describe "Associations" do
    it { should belong_to(:created_by).class_name(User.name) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:capacity) }
  end
end
