class HomeController < ApplicationController
  def index
    @patients = Patient.all
    if signed_in?
      @user = current_user
    end
  end
end
