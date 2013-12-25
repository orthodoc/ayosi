class PatientsController < ApplicationController
  def new
    if signed_in?
      @user = User.find_by_id(current_user.id)
      @hospital = @user.designations[0].hospital
      @patient = Patient.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end
end
