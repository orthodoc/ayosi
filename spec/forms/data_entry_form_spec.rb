require 'spec_helper'

describe DataEntryForm do

  subject { DataEntryForm.new(patient: FactoryGirl.create(:patient), surgery: FactoryGirl.create(:surgery)) }

  it { should validate_presence_of(:name).on(:patient) }
  it { should validate_presence_of(:age).on(:patient) }
  it { should validate_presence_of(:gender).on(:patient) }
  it { should validate_numericality_of(:age) }
  
  it { should validate_presence_of(:name).on(:surgery) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:hospital_id) }
  it { should validate_presence_of(:uhid) }
  it { should validate_presence_of(:patient_id) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:side) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:diagnosis) }

  #This is a bug. See: 
  #https://github.com/thoughtbot/shoulda-matchers/issues/457
  #https://github.com/thoughtbot/shoulda-matchers/issues/203
  #it { should validate_uniqueness_of(:name).scoped_to(:date, :hospital_id, :patient_id, :category, :side, :region, :surgeon).on(:surgery) }

  it { should ensure_inclusion_of(:category).in_array(%w(Primary Revision)) }
  it { should ensure_inclusion_of(:side).in_array(%w(Right Left)) }
  it { should ensure_inclusion_of(:region).in_array(%w(Hip Knee Shoulder)) }

end
