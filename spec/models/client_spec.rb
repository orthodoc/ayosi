require 'spec_helper'

describe Client do

  subject { FactoryGirl.create(:client) }

  it { should belong_to(:user) }
  it { should belong_to(:patient) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:patient) }

end
