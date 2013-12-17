require 'spec_helper'

describe Designation do

  subject { FactoryGirl.create(:designation) }

  it { should belong_to(:user) }
  it { should belong_to(:hospital) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:hospital) }
  it { should validate_uniqueness_of(:name).scoped_to([:user_id, :hospital_id])}

end
