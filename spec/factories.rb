require 'factory_girl'
require 'faker'

FactoryGirl.define do 
  factory :post do
    name { Faker::Name.name }
  end

  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    status { rand(2).zero? }
    post
  end
end