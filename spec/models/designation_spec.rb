require 'spec_helper'

describe Designation do


  subject { FactoryGirl.create(:designation) }
  
  it { should belong_to(:user) }
  it { should belong_to(:hospital) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:hospital) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:hospital_id) }
  it { should validate_uniqueness_of(:is_default).scoped_to(:user_id, :hospital_id) unless Proc.new { |designation| designation.is_default == 0 }  }
  it { should accept_nested_attributes_for(:hospital) }
  it { should accept_nested_attributes_for(:user) }

end
