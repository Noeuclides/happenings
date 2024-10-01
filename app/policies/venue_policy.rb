class VenuePolicy < ApplicationPolicy
  pre_check :allow_admin_or_organizer, only: %i[ index? new? create? ]
  pre_check :allow_venue_creator, only: :manage?

  def destroy?
    admin?
  end

  private

  def allow_venue_creator
    allow! if has_allowed_role? && user.id == record.created_by_id
  end
end
