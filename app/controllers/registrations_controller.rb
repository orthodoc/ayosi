class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
  after_filter :adding_patient_role_and_designation

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :category)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :category)}
  end

  # Only hospital staff have the option to choose their designated roles.
  # For a patient, the user category, role name and designation name are all the
  # same, ie: "patient". This also means that a user controller method will be
  # required that will reverse the process if the user updates the user category
  # from patient to something else.
  def adding_patient_role_and_designation
    if resource.persisted?
      if resource.category == "patient"
        resource.add_role :patient
        designation = Designation.find_or_create_by(name: "patient")
        resource.designations << designation
      end
    end
  end

end
