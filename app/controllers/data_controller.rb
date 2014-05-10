class DataController < ApplicationController

  before_filter :find_user

  include Wicked::Wizard
  steps :patient, :surgery, :implants #, :xrays, :images, :outcomes

  def show
    @patient = PatientForm.new(@user.patients.build)
    render_wizard
  end

  def update
    @patient = PatientForm.new(@user.patients.create(patient_params))
    if @patient.save
      flash[:notice] = "Patient #{@patient.name} added to the database"
    else
      flash[:alert] = "Patient was not saved due to errors!"
    end
    render_wizard @patient
  end

  private

  def find_user
    if signed_in?
      @user = current_user
      @hospital = @user.default_hospital
    else
      flash[:alert] = "You have to be signed in first"
      redirect_to new_user_session_path
    end
  end

  def patient_params
    params.require(:patient).permit(:id, :name, :age, :birthday, :gender)
  end

end
