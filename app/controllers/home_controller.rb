class HomeController < ApplicationController
  def index
    if signed_in?
      @user = current_user.decorate
    end
  end

end
