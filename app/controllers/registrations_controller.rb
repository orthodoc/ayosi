class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
#  after_filter :adding_role

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :category)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :category)}
  end

#  def adding_role
#    if resource.persisted?
#      if resource.category == "guest"
#        resource.add_role :guest
#      else resource.category == "patient"
#        resource.add_role :patient
#      end
#    end
#  end

end
