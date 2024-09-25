require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do
  let(:admin_user) {
    Admin::User.create!()
  }

  before(:each) do
    assign(:admin_user, admin_user)
  end

  it "renders the edit admin_user form" do
    render

    assert_select "form[action=?][method=?]", admin_user_path(admin_user), "post" do
    end
  end
end
