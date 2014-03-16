class HospitalsController < ApplicationController
  before_filter :find_hospital, only: :show

  def index
    if signed_in?
      @hospitals = Hospital.order(:name).select(:id, :name, :city)
      render json: @hospitals
    else
      flash[:alert] = "You have to sign in first!"
      redirect_to new_user_session_path
    end
  end

  def show
    @hospital
  end

  def edit
    if current_user.has_role? :admin
      @hospital
    else
      flash[:alert] = "Only an admin can change the hospital details"
      redirect_to :back
    end
  end

  private
  
  def find_hospital
    @hospital = Hospital.find(params[:id]).decorate
  end
end
