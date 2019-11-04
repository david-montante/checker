require 'ffaker'

FactoryGirl.define do
  factory :user, class: User do |f|
    f.first_name       {FFaker::NameMX.name}
    f.last_name        {FFaker::NameMX.last_name}
    f.email            {FFaker::Internet.safe_email}
    f.password         {FFaker::Internet.password}
  end
end
