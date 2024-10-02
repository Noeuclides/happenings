class EventPolicy < ApplicationPolicy
  pre_check :allow_admin_or_organizer, only: %i[ new? create? ]
  pre_check :allow_event_owner, only: :manage?

  def index?
    true
  end

  def show?
    true
  end

  def register?
    true
  end

  def unregister?
    true
  end

  private

  def allow_event_owner
    allow! if has_allowed_role? && user.id == record.organizer_id
  end
end
