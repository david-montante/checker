require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation tests" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "is invalid without first_name" do
      expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
    end

    it "is invalid without last_name" do
      expect(FactoryGirl.build(:user, last_name: nil)).to_not be_valid
    end

    it "is invalid without email" do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end

  end
end
