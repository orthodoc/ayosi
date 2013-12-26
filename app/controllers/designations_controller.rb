class DesignationsController < ApplicationController
  before_filter :find_user
  def new
    if signed_in?
      @designation = Designation.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @designation = Designation.new(params[:designation].permit(:name, :hospital_id, :user_id, :aasm_state))
    if @designation.save
      flash[:notice] = "Thank you for the submission"
      redirect_to @user
    else
      flash[:alert] = "Role was not created"
      render action: "new"
    end
  end

  def edit
    if signed_in?
      @designation = Designation.find(params[:id])
    else
      flash[:alert] = "You have to sign in to update the designation"
      redirect_to new_user_session_path
    end
  end

  def update
    @designation = Designation.find(params[:id])
    if @designation.update_attributes(params[:designation].permit(:name, :hospital_id, :user_id, :aasm_state))
      flash[:notice] = "Designation has been updated"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Designation has not been updated"
      render action: "edit"
    end
  end

  def destroy
    @designation = Designation.find(params[:id])
    @designation.destroy
    flash[:alert] = "Designation has been deleted!"
    redirect_to user_path(@user)
  end

  def requesting
    if signed_in?
      @designation = Designation.find(params[:id])
      if @designation.inactive?
        @designation.request!
      end
      flash[:notice] = "Request submitted!"
      redirect_to user_path(@user)
    end
  end

  private

  def find_user
    @user = current_user
  end

end
