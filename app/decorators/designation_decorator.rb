class DesignationDecorator < ApplicationDecorator
  delegate_all

  def delete_link(user)
    if user.designations.include?(model)
      trash_link
    end
  end

end
