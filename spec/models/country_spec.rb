require 'spec_helper'

describe Country do
  context 'attributes' do
    subject { FactoryGirl.create :country }

    it { should have_many :regions }
    it_behaves_like "locations"
  end
end
