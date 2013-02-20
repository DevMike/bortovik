require 'spec_helper'

describe UserVehicle do
  it { should belong_to :user }
  it { should belong_to :vehicle }
end
