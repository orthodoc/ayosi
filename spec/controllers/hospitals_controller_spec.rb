require 'spec_helper'

describe HospitalsController do

  before(:each) do
    get :index
  end

  it { should respond_with(:success) }
  it { should render_template(:index) }
  it { should_not set_the_flash }
  it { assigns(:hospitals).should_not eq(HospitalDecorator.decorate(:hospital)) }

end
