require 'spec_helper'

describe Client do

  subject { FactoryGirl.create(:client) }

  it { should belong_to(:user) }
  it { should belong_to(:patient) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:patient) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:patient_id) }

end
