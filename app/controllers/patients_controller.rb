class PatientsController < ApplicationController
  def new
    if signed_in?
      @user = User.find_by_id(current_user.id)
      @hospital = @user.designations.first.hospital
      @patient = Patient.new
    else
      redirect_to new_user_session_path
    end
  end
end
