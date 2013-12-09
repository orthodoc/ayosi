require 'spec_helper'

describe PatientsController do

  before(:each) do
    get :new
    @patient = FactoryGirl.build(:patient)
  end

  it { should route(:get, 'patients/new').to(action: :new) }
  it { should respond_with(:success) }
  it { should render_template(:new) }

end
