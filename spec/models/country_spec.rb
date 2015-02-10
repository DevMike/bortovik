# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Country do
  context 'attributes' do
    subject { FactoryGirl.create :country }

    it { should have_many :regions }
  # it_behaves_like "locations"
  end
end
