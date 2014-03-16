class MembershipDecorator < ApplicationDecorator
  delegate_all

  def delete_link(team)
    if team.memberships.include?(model)
      if team.owner == h.current_user
        trash_link
      else
        return nil
      end
    else
      return nil
    end
  end

end
