require 'spec_helper'

describe Settlement do
  context 'attributes' do
    subject { FactoryGirl.create :settlement }

    it { should validate_presence_of :name }
    it { should validate_presence_of :russian_name}
    it { should belong_to :region }
  end
end
