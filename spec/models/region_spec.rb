require 'spec_helper'


describe Region do
  context 'attributes' do
    subject { FactoryGirl.create :region }

    it { should belong_to :country }
    it { should have_many :settlements }
    it_behaves_like "locations"
  end
end
