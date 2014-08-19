# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  country_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Region do
  context 'attributes' do
    subject { FactoryGirl.create :region }

    it { should belong_to :country }
    it { should have_many :settlements }
    it { should validate_presence_of :country_id }
  # it_behaves_like "locations"
  # it_behaves_like "uniqueness regarding parent", :region, :country_id, [:name]
  end
end
