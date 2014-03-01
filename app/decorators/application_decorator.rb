class ApplicationDecorator < Draper::Decorator

  # Place all common view logic in this file. Also make sure that all the other
  # decorators that need this logic inherit from this decorator
  # eg. TeamDecorator < ApplicationDecorator

  def trash_link
    unless model == h.current_user
      h.link_to h.content_tag(:i, nil, class: "fa fa-trash-o light-red"),
        model,
        alt: "Delete",
        method: :delete,
        data: { confirm: "Are you sure you want to remove #{model.name}" }
    end
  end

  def delete_button
    h.link_to h.fa_icon("trash-o", text: "Delete"),
      object,
      method: :delete,
      data: { confirm: "Are you sure?" },
      class: "button-mini alert"
  end

end
