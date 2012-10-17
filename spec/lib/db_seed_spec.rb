require 'spec_helper'

describe "Db Seed" do
  pending "runs successfully" do
    lambda {
      require Rails.root.join('db/seeds')
    }.should_not raise_error
  end
end