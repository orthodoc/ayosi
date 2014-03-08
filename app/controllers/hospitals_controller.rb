class HospitalsController < ApplicationController


  def index
    if signed_in?
      @hospitals = Hospital.order(:name).select(:id, :name, :city)
      render json: @hospitals
    else
      flash[:alert] = "You have to sign in first!"
      redirect_to new_user_session_path
    end
  end
end
