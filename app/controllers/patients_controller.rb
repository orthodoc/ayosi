class PatientsController < ApplicationController
  before_filter :find_user

  def new
    @hospital = @user.default_hospital
    @form = PatientForm.new(Patient.new)
  end

  private

  def find_user
    if signed_in?
      @user = current_user
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end
end
