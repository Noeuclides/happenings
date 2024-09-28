module ApplicationHelper
  def admin?
    current_user.has_role? :admin
  end

  def organizer?
    current_user.has_role? :organizer
  end

  def user_initials
    "#{current_user.first_name[0]}#{current_user.last_name[0]}".upcase
  end
end
