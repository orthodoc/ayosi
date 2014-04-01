require 'spec_helper'

describe Surgery do

  subject { FactoryGirl.create(:surgery) }

  it { should belong_to(:hospital) }
  it { should belong_to(:patient) }

end
