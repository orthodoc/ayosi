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
    @designation = Designation.find(params[:designation_id])
    if @designation.update_attributes(is_default: true)
      flash[:notice] = "Designation was made default"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Designation was not updated"
      redirect_to user_path(@user)
    end
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
    @user = current_user
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
