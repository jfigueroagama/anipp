require 'factory_girl'

FactoryGirl.define do
  
  sequence :email do |n|
    "person_#{n}@example.com"
  end
  
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    email
    telephone             "55 1107 8657"
    password              "foobar"
    password_confirmation "foobar"
     
    factory :admin do
      admin true
    end
  end
  
  factory :location do
    street                "Division del Norte 712" 
    city                  "Mexico" 
    state                 "Distrito Federal"
    latitude              19.40 
    longitude             -99.16 
    center_name           "Parto Natural"
    association :user
  end
end