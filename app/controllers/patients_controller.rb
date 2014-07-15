class PatientsController < ApplicationController
  before_filter :find_user

  def index
    @patients = @user.patients.text_search(params[:query])
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = PatientForm.new(@user.patients.build)
  end

  def create
    @patient = PatientForm.new(@user.patients.create(patient_params))
    if @patient.save
      flash[:notice] = "Patient #{@patient.name} added to the database"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Patient was not saved due to errors!"
      render action: :new
    end
  end

  private

  def find_user
    if signed_in?
      @user = current_user.decorate
      @hospital = @user.default_hospital
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def patient_params
    params.require(:patient).permit(:id, :name, :age, :birthday, :gender)
  end
end
