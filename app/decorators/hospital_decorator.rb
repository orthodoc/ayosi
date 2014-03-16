class HospitalDecorator < ApplicationDecorator
  delegate_all

  def name_link
    h.link_to name, h.edit_hospital_path(model)
  end

  def title
    name_link.concat(
      h.content_tag(:span, " (".concat(city).concat(")"))
    )
  end

end
