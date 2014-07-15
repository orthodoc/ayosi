class DesignationsController < ApplicationController
  before_filter :find_user
  before_filter :find_designation, only: [:update, :edit, :destroy, :requesting, :activating, :rejecting, :deactivating, :banning, :resigning]

  def new
    if signed_in?
      @designation = Designation.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @designation = Designation.new(designation_params)
    if @designation.save
      flash[:notice] = "Thank you for the submission"
      redirect_to @user
    else
      flash[:alert] = "Role was not created"
      render action: "new"
    end
  end

  def edit
    @designation
  end

  def update
    if @designation.update_attributes(designation_params)
      flash[:notice] = "Designation has been updated"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Designation has not been updated"
      render action: "edit"
    end
  end

  def make_default
    if params[:designation_id].nil?
      flash[:alert] = "Select any one designation to make default"
    else
      @designation = Designation.find(params[:designation_id])
      unless @designation.is_default == true
        @designation.update_attributes(is_default: true)
        flash[:notice] = "Designation was made default"
      end
    end
    redirect_to user_path(@user)
  end

  def destroy
    @designation.destroy
    flash[:alert] = "Designation #{@designation.name} has been deleted!"
    redirect_to user_path(@user)
  end

  private

  def designation_params
    params.require(:designation).permit(:id, :name, :user_id, :hospital_id, :is_default)
  end

  def find_user
    if signed_in?
      @user = current_user.decorate
    else
      flash[:alert] = "You have to sign in first!"
      redirect_to new_user_session_path
    end
  end

  def find_designation
    if signed_in?
      @designation = Designation.find(params[:id])
    else
      flash[:alert] = "You have to sign in first!"
      redirect_to new_user_session_path
    end
  end
end
