class DesignationsController < ApplicationController
  before_filter :find_user
  before_filter :find_designation, only: [:update, :destroy, :requesting, :activating, :rejecting, :deactivating, :banning, :resigning]

  def new
    if signed_in?
      @designation = Designation.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @designation = Designation.new(params[:designation].permit(:name, :hospital_id, :user_id, :is_default, :aasm_state))
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
    if @designation.update_attributes(params[:designation].permit(:name, :hospital_id, :user_id, :is_default, :aasm_state))
      flash[:notice] = "Designation has been updated"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Designation has not been updated"
      render action: "edit"
    end
  end

  def destroy
    @designation.destroy
    flash[:alert] = "Designation #{@designation.name} has been deleted!"
    redirect_to user_path(@user)
  end

  def requesting
    if @designation.inactive?
      @designation.request!
    end
    flash[:notice] = "Request submitted!"
    redirect_to user_path(@user)
  end

  def activating
    if @designation.inactive? || @designation.pending?
      @designation.activate!
    end
    flash[:notice] = "Membership activated!"
    redirect_to :back
  end

  def rejecting
    if @designation.pending?
      @designation.reject!
    end
    flash[:notice] = "Membership was rejected!"
    redirect_to :back
  end

  def deactivating
    if @designation.active?
      @designation.deactivate!
    end
    flash[:notice] = "Membership was deactivated!"
    redirect_to :back
  end

  def banning
    if @designation.active? || @designation.pending? || @designation.rejected?
      @designation.ban!
    end
    flash[:notice] = "Member was banned!"
    redirect_to :back
  end

  def resigning
    if @designation.active?
      @designation.resign!
    end
    flash[:notice] = "You have resigned from membership!"
    redirect_to :back
  end

  private

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
