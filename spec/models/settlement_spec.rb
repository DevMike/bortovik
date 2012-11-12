require 'spec_helper'

describe Settlement do
  context 'attributes' do
    subject { FactoryGirl.create :settlement }

    it { should belong_to :region }
    it { should validate_presence_of :region_id }
    it_behaves_like "locations"
  end
end
