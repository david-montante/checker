require 'ffaker'

FactoryGirl.define do
  factory :assist, class: Assist do |f|
    f.check_in       {FFaker::Time.datetime}
    f.check_out        {FFaker::Time.datetime}
    f.user 
  end
end
