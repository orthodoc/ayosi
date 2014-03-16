class TeamDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  decorates_association :members
  decorates_association :memberships

  def delete_link(user)
    if user == model.owner
      trash_link
    end
  end

  def current_user_name
    h.link_to h.current_user.name, h.user_path(h.current_user)
  end

  def current_user_membership
    h.current_user.memberships.find_by(team: model)
  end

  def current_user_membership_status
    current_user_membership.aasm_state.titleize
  end

  def disabled_button
    h.button_to "Disabled",
      "",
      method: :get,
      class: "button-mini disabled"
  end

  def request_button
    h.button_to "Request",
      h.requesting_membership_path(current_user_membership),
      class: "button-mini"
  end

  def resign_button
    h.button_to "Resign",
      h.resigning_membership_path(current_user_membership),
      class: "button-mini"
  end

  def current_user_membership_button
    unless h.current_user == model.owner
      if current_user_membership_status == "Inactive"
        request_button
      elsif current_user_membership_status == "Pending"
        disabled_button
      elsif current_user_membership_status == "Active"
        resign_button
      elsif current_user_membership_status == "Rejected"
        request_button
      else current_user_membership_status == "Banned"
        disabled_button
      end
    end
  end

  def current_user_display
    if members.include?(h.current_user)
      if h.current_user == model.owner
        h.content_tag(:span, current_user_name.concat(" (Owner)"))
      else
        h.content_tag(:span, current_user_name
                      .concat(": Your membership is ")
                      .concat(current_user_membership_status)
                      .concat(current_user_membership_button)
                     )
      end
    else
      h.content_tag(:span, current_user_name.concat(": You do not work in this hospital"))
    end
  end

  def display_members
    members.reject{ |m| m == h.current_user || m.membership_status(model) == "Banned" }
  end

  def invite_by_email_link
    if h.current_user == model.user
      h.link_to "Invite by email", h.new_user_invitation_path
    end
  end

end
