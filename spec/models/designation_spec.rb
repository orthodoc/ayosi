require 'spec_helper'

describe Designation do

  subject { FactoryGirl.create(:designation) }

  it { should belong_to(:user) }
  it { should belong_to(:hospital) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:hospital) }

end
