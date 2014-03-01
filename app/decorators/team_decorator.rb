class TeamDecorator < ApplicationDecorator
  delegate_all
  decorates_finders
  decorates_association :members

  def delete_link(user)
    if user.teams.include?(model)
      trash_link
    end
  end

  def current_user_name
    h.link_to h.current_user.name, h.user_path(h.current_user)
  end

  def current_user_designation
    h.current_user.designations.find_by(hospital: model.hospital)
  end

  def current_user_designation_status
    current_user_designation.aasm_state.titleize
  end

  def disabled_button
    h.button_to "Disabled",
      "",
      method: :get,
      class: "button-mini disabled"
  end

  def request_button
    h.button_to "Request",
      h.requesting_designation_path(current_user_designation),
      class: "button-mini"
  end

  def resign_button
    h.button_to "Resign",
      h.resigning_designation_path(current_user_designation),
      class: "button-mini"
  end

  def current_user_designation_button
    unless h.current_user == model.owner
      if current_user_designation_status == "Inactive"
        request_button
      elsif current_user_designation_status == "Pending"
        disabled_button
      else current_user_designation_status == "Active"
        resign_button
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
                      .concat(current_user_designation_status)
                      .concat(current_user_designation_button)
                     )
      end
    end
  end

  def members_except_current_user
    members.reject{ |m| m == h.current_user }
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
