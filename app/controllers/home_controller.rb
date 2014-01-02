class HomeController < ApplicationController
  def index
    if signed_in?
      @user = current_user
    end
  end

  def show
    if signed_in?
      @user = current_user
    end
  end


end
