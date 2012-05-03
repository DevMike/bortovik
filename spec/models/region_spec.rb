require 'spec_helper'

describe Region do
  context 'attributes' do
    subject { FactoryGirl.create :region }

    it { should validate_presence_of :name }
    it { should validate_presence_of :russian_name}
    it { should belong_to :country }
    it { should have_many :settlements }
  end
end
