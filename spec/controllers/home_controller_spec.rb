require 'spec_helper'

describe HomeController do

  before(:each) do
    get :index
  end

  it { should respond_with(:success) }
  it { should render_template(:index) }
  it { should_not set_the_flash }

end
