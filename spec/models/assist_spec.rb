require 'rails_helper'

RSpec.describe Assist, type: :model do
  describe "Validation tests" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:assist)).to be_valid
    end

    it "is invalid without check_in" do
      expect(FactoryGirl.build(:assist, check_in: nil)).to_not be_valid
    end
  end
end
