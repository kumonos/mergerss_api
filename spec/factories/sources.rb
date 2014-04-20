require 'faker'

FactoryGirl.define do
  factory :source do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    source_url { Faker::Internet.url }
    link_url { Faker::Internet.url }
    image_url { Faker::Internet.url }
    parser_class { ['RSSParser', 'QiitaParser'].sample }
    last_published_at { Random.rand(1 .. 50000).minutes.ago }
  end
end
