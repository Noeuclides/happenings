class ApplicationPolicy < ActionPolicy::Base
  private

  def admin?
    user.has_role? :admin
  end

  def organizer?
    user.has_role? :organizer
  end

  def has_allowed_role?
    admin? || organizer?
  end

  def allow_admin_or_organizer
    allow! if has_allowed_role?
  end
end
