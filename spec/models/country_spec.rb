require 'spec_helper'

describe Country do
  context 'attributes' do
    subject { FactoryGirl.create :country }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name}
    it { should validate_presence_of :russian_name}
    it { should have_many :regions }
  end
end
