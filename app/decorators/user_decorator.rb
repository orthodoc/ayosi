class UserDecorator < ApplicationDecorator
  delegate_all
  decorates_association :designations
  decorates_association :teams
  decorates_association :roles
  decorates_association :memberships

  def role_name
    if roles.count == 0
      category.titleize
    else
      roles[0].name.titleize
    end
  end

  def name_link
    if h.current_user == model
      h.link_to name,
        h.user_path(model)
    else
      name
    end
  end

  def welcome_title
    if h.signed_in?
      name_link 
      content_tag(:span, " (".concat(role_name).concat(")"))
    else
      "Welcome Vistor!"
    end
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
    designation(team).name.titleize
  end

  def membership(team)
    team.memberships.find_by(user: model)
  end

  def membership_status(team)
    membership(team).aasm_state.capitalize
  end

  def activate_button(team)
    h.button_to "Activate",
      h.activating_membership_path(membership(team)),
      class: "button-mini"
  end

  def reject_button(team)
    h.button_to "Reject",
      h.rejecting_membership_path(membership(team)),
      class: "button-mini"
  end

  def deactivate_button(team)
    h.button_to "Deactivate",
      h.deactivating_membership_path(membership(team)),
      class: "button-mini"
  end

  def ban_button(team)
    h.button_to "Ban",
      h.banning_membership_path(membership(team)),
      class: "button-mini"
  end

  def disabled_button
    h.button_to "Deactivate",
      "",
      method: :get,
      class: "button-mini disabled"
  end

  def request_button(team)
    h.button_to "Request",
      h.requesting_membership_path(membership(team)),
      class: "button-mini"
  end

  def resign_button(team)
    h.button_to "Resign",
      h.resigning_membership_path(membership(team)),
      class: "button-mini"
  end

  def action_button(team)
    if h.current_user == team.owner
      if model == h.current_user
        disabled_button(team)
      else
        if membership_status(team) == "Inactive"
          activate_button(team)
        elsif membership_status(team) == "Pending"
          activate_button(team)
        else membership_status(team) == "Active"
          deactivate_button(team)
        end
      end
    else
      if model == h.current_user
        if membership_status(team) == "Inactive"
          request_button(team)
        elsif membership_status(team) == "Pending"
          disabled_button(team)
        else membership_status(team) == "Active"
          resign_button(team)
        end
      end
    end
  end


  def delete_membership(team)
    membership(team).delete_link(h.current_user)
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
