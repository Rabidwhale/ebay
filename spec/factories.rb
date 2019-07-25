FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com" 
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :prod do
    name { "airpods" }
    description { "airpods" }
    cost { 0.1e3 }
    association :user
  end
end