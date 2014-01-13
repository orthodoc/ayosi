class PatientsController < ApplicationController
  def new
    if signed_in?
      @user = current_user
      @hospital = @user.hospitals.first
      @patient = Patient.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end
end
