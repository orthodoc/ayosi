require 'spec_helper'

describe Designation do

  before(:each) do
    @designation = FactoryGirl.create(:designation)
  end

  it { should belong_to(:user) }
  it { should belong_to(:hospital) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:hospital) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:hospital_id) }
  it { should validate_uniqueness_of(:is_default).scoped_to(:user_id, :hospital_id) unless Proc.new { |designation| designation.is_default == 0 }  }
  it { should accept_nested_attributes_for(:hospital) }
  it { should accept_nested_attributes_for(:user) }

  context "deleting all the associated teams as a doctor" do
    before(:each) do
      @team = FactoryGirl.create(:team, user: @designation.user)
      @designation.destroy
    end
    it { expect change(Team, :count).by(-1) }
  end

  context " deleting unassociated teams" do
    before(:each) do
      @new_hospital = FactoryGirl.create(:hospital)
      @team = FactoryGirl.create(:team, user: @designation.user)
      @designation.update_attributes(hospital: @new_hospital)
    end
    it { expect change(Team, :count).by(0) }
  end

end
