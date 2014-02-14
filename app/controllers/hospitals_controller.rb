class HospitalsController < ApplicationController

  def index
    @user = current_user
    if signed_in?
      @hospitals = Hospital.order(:name).select(:id, :name, :city)
      render json: @hospitals
    end
  end

  def show
    @user = current_user
    @hospital = Hospital.find(params[:id])
  end
end
