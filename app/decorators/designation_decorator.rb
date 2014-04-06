class DesignationDecorator < ApplicationDecorator
  delegate_all

  def delete_link(user)
    if user.designations.include?(model)
      trash_link
    end
  end

  def make_default_button
    unless model.is_default == true
      h.radio_button_tag "designation_id", model.id
    else
      h.content_tag(:i, "", class: "fa fa-check-circle")
    end
  end

end
