class MembershipsController < ApplicationController
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    flash[:alert] = "Membership has been deleted"
    redirect_to :back
  end
end
