require 'spec_helper'

describe Vehicle do
  it { should have_many :users }
  it { should have_many :car_feature_car_modifications }
  it { should belong_to :car_modification }
  it { should validate_presence_of :color }
  it { should validate_presence_of :mileage }
  it { should validate_presence_of :car_modification }

  describe "owner" do
    let(:user){ FactoryGirl.create(:user) }
  end
end
