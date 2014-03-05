require 'spec_helper'

describe HomeController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    get :index
  end

  it { should respond_with(:success) }
  it { should render_template(:index) }
  it { should_not set_the_flash }
  it { assigns(:user).should eq(UserDecorator.decorate(@user)) }

end
