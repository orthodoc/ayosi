class MembershipsController < ApplicationController
  before_filter :find_user
  before_filter :find_membership, only: [:destroy, :requesting, :activating, :rejecting, :deactivating, :banning, :resigning]

  def destroy
    @membership.destroy
    flash[:alert] = "Membership has been deleted"
    redirect_to :back
  end

  def requesting
    if @membership.inactive?
      @membership.request!
    end
    flash[:notice] = "Request submitted!"
    redirect_to user_path(@user)
  end

  def activating
    if @membership.inactive? || @membership.pending?
      @membership.activate!
    end
    flash[:notice] = "Membership activated!"
    redirect_to :back
  end

  def rejecting
    if @membership.pending?
      @membership.reject!
    end
    flash[:alert] = "Membership was rejected!"
    redirect_to :back
  end
  
  def deactivating
    if @membership.active?
      @membership.deactivate!
    end
    flash[:notice] = "Membership was deactivated!"
    redirect_to :back
  end

  def banning
    if @membership.active? || @membership.pending? || @membership.rejected?
      @membership.ban!
    end
    flash[:notice] = "Member was banned!"
    redirect_to :back
  end
  
  def resigning
    if @membership.active?
      @membership.resign!
    end
    flash[:alert] = "You have resigned as a member!"
    redirect_to :back
  end

  private

  def find_user
    @user = current_user
  end

  def find_membership
    @membership = Membership.find(params[:id])
  end
end
