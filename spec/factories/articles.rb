require 'faker'

FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.word }
    summary { Faker::Lorem.paragraph }
    link_url { Faker::Internet.url }
    published_at { Random.rand(1 .. 50000).minutes.ago }
  end
end
