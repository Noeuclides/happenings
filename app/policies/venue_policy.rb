class VenuePolicy < ApplicationPolicy
  pre_check :allow_admins

  def index?
    organizer?
  end

  def create?
    organizer?
  end

  def show?
    debugger
    user.id == record.created_by_id
  end

  def update?
    user.id == record.created_by_id
  end


  # def index?
  #   admin? || (user.id == record.created_by_id)
  # end
  #
  # def update?
  #   # here we can access our context and record
  #   user.admin? || (user.id == record.user_id)
  # end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
  private

  def allow_admins
    allow! if admin?
  end
end
