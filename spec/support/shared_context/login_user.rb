RSpec.shared_context :login_user do |role: :admin|
  let(:user) { create(:user, :confirmed, role) }

  before do
    sign_in user
  end
end