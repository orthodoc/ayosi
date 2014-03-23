require 'spec_helper'

describe Surgery do

  subject { FactoryGirl.create(:surgery) }

  it { should belong_to(:hospital) }
  it { should belong_to(:patient) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to([:date, :hospital_id, :patient_id, :category, :side, :region, :surgeon])}
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:hospital) }
  it { should validate_presence_of(:uhid) }
  it { should validate_presence_of(:patient) }
  it { should validate_presence_of(:category) }
  it { should ensure_inclusion_of(:category).in_array(%w(Primary Revision)) }
  it { should validate_presence_of(:side) }
  it { should ensure_inclusion_of(:side).in_array(%w(Right Left)) }
  it { should validate_presence_of(:region) }
  it { should ensure_inclusion_of(:region).in_array(%w(Hip Knee Shoulder)) }
  it { should validate_presence_of(:surgeon) }

end
