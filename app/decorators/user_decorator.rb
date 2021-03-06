class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_association :designations
  decorates_association :teams
  decorates_association :roles
  decorates_association :memberships
  decorates_association :hospitals

  def role_name
    if roles.count == 0
      category.titleize
    else
      roles[0].name.titleize
    end
  end

  def name_link
    h.link_to name,
      h.user_path(model)
  end

  def owner_title(team)
    if model == team.owner
      "(Owner)"
    end
  end

  def designation(team)
    model.designations.find_by(hospital: team.hospital)
  end

  def designation_name(team)
    designation(team).name.titleize unless designation(team).nil?
  end

  def membership(team)
    model.memberships.find_by(team_id: team.id)
  end

  def membership_status(team)
    membership(team).aasm_state.capitalize
  end

  def activate_button(team)
    h.button_to "Activate",
      h.activating_membership_path(membership(team)),
      class: "btn-xs btn-primary"
  end

  def reject_button(team)
    h.button_to "Reject",
      h.rejecting_membership_path(membership(team)),
      class: "btn-xs btn-warning"
  end

  def deactivate_button(team)
    h.button_to "Deactivate",
      h.deactivating_membership_path(membership(team)),
      class: "btn-xs btn-warning"
  end

  def ban_button(team)
    h.button_to "Ban",
      h.banning_membership_path(membership(team)),
      class: "btn-xs btn-danger"
  end

  def disabled_button
    h.button_to "Disabled",
      "",
      method: :get,
      class: "btn-xs btn-primary",
      disabled: "disabled"
  end

  def request_button(team)
    h.button_to "Request",
      h.requesting_membership_path(membership(team)),
      class: "btn-xs btn-primary"
  end

  def resign_button(team)
    h.button_to "Resign",
      h.resigning_membership_path(membership(team)),
      class: "btn-xs btn-primary"
  end

  def action_button(team)
    if h.current_user == team.owner
      if membership_status(team) == "Inactive"
        activate_button(team)
      elsif membership_status(team) == "Pending"
        activate_button(team).concat(reject_button(team))
      elsif membership_status(team) == "Active"
        deactivate_button(team).concat(ban_button(team))
      else membership_status(team) == "Rejected"
        ban_button(team)
      end
    end
  end

end
