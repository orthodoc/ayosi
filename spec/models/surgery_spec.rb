require 'spec_helper'

describe Surgery do

  subject { FactoryGirl.create(:surgery) }

  it { should belong_to(:hospital) }
  it { should belong_to(:patient) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:hospital) }
  it { should validate_presence_of(:patient) }

end
