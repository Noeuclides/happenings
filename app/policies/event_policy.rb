class EventPolicy < ApplicationPolicy
  pre_check :allow_admin_or_organizer, only: %i[ index? new? create? ]
  pre_check :allow_event_owner, only: :manage?

  private

  def allow_event_owner
    allow! if has_allowed_role? && user.id == record.organizer_id
  end
end
