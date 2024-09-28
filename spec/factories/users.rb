# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { 'Juan' }
    last_name { 'Perez' }
    email { 'test@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }

    trait :pending do
      confirmation_token { 'some-confirmation-token' }
      confirmed_at { nil }
    end

    trait :confirmed do
      confirmed_at { Time.current }
    end

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :assistant do
      after(:create) { |user| user.add_role(:assistant) }
    end

    trait :organizer do
      after(:create) { |user| user.add_role(:organizer) }
    end
  end
end
