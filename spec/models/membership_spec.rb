require 'spec_helper'

describe Membership do

  subject { FactoryGirl.create(:membership) }

  it { should belong_to(:user) }
  it { should belong_to(:team) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:team) }
end
