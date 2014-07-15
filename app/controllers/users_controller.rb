class UsersController < ApplicationController
  before_filter :find_user
  respond_to :html

  def show
    @designations = @user.designations
  end

  def update
    if @user.update_attributes(params[:user].permit(:role_ids, :designations_attributes))
      redirect_to user_path(@user), notice: "User updated."
    else
      redirect_to user_path(@user), alert: "Unable to update user"
    end
  end

  # This method is useful to get the list of users related to the hospital when
  # forming a team
  def index
    @hospital = Hospital.find(params[:hospital_id])
    @users = @hospital.users.where(category: "hospital_staff").order(:name)
    respond_with @users do |format|
      format.json
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
