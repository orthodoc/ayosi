class UsersController < ApplicationController

  def show
    if signed_in?
      @user = current_user
      @designations = @user.designations
    else
      redirect_to new_user_session_path
      flash[:alert] = "You must sign in first!"
    end
  end

end
