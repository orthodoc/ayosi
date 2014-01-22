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

  def update
    if signed_in?
      @user = current_user
      if @user.update_attributes(params[:user].permit(:role_ids, :designations_attributes))
        redirect_to user_path(@user), notice: "User updated."
      else
        redirect_to user_path(@user), alert: "Unable to update user"
      end
    end
  end

  def index
    if signed_in?
      @users = User.order(:name)
      respond_to do |format|
        format.html
        format.json { render json: @users }
      end
    end
  end

end
