class Admin::UserPolicy < ApplicationPolicy
  pre_check :allow_admins

  private

  def allow_admins
    allow! if admin?
  end
end
