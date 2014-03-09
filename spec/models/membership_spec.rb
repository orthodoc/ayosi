require 'spec_helper'

describe Membership do

  subject { FactoryGirl.create(:membership) }

  it { should belong_to(:user) }
  it { should belong_to(:team) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:team) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:team_id) }

  it { should accept_nested_attributes_for(:user) }
  it { should accept_nested_attributes_for(:team) }
end
