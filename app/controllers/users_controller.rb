class UsersController < ApplicationController
  before_filter :find_user
  respond_to :html, :json

  def show
    @designations = @user.designations
    @teams = @user.teams
  end

  def update
    if @user.update_attributes(params[:user].permit(:role_ids, :designations_attributes))
      redirect_to user_path(@user), notice: "User updated."
    else
      redirect_to user_path(@user), alert: "Unable to update user"
    end
  end

  private

  def find_user
    if signed_in?
      @user = current_user.decorate
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

end
