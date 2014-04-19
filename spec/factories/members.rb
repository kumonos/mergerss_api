require 'faker'

FactoryGirl.define do
  factory :member do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    link_url { Faker::Internet.url }
    image_url { Faker::Internet.url }
    last_published_at { Random.rand(1 .. 50000).minutes.ago }
  end
end
