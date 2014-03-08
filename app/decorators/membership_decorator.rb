class MembershipDecorator < ApplicationDecorator
  delegate_all

  def delete_link(team)
    if team.memberships.include?(model)
      if team.owner == h.current_user
        trash_link
      end
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
