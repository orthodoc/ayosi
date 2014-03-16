class ApplicationDecorator < Draper::Decorator

  # Place all common view logic in this file. Also make sure that all the other
  # decorators that need this logic inherit from this decorator
  # eg. TeamDecorator < ApplicationDecorator

  def display_name
    # This is necessary as the membership model does not have a method :name, ie:
    # the membership table has no attribute by "name"
    unless model.methods.include?(:name)
      model.class.name.capitalize.concat(" no: ").concat(model.id.to_s)
    else
      model.name.titleize
    end
  end

  def trash_link
    unless model == h.current_user
      h.link_to h.content_tag(:i, nil, class: "fa fa-trash-o light-red"),
        model,
        alt: "Delete",
        method: :delete,
        data: { confirm: "Are you sure you want to remove #{display_name}" }
    end
  end

end
