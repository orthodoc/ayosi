class HospitalsController < ApplicationController
  def index
    @user = current_user
    if signed_in?
      @hospitals = Hospital.order(:name).select(:id, :name, :city)
      render json: @hospitals
    end
  end
end
