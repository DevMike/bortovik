# encoding: UTF-8

describe ContactMessage do
  context "attributes" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:description) }

    it { should ensure_length_of(:description).is_at_most(1000) }

    it { should allow_value('paranoid@gmail.com').for(:email) }
    it { should_not allow_value('').for(:email) }
    it { should_not allow_value('paranoid.gmail.com').for(:email) }
  end
end