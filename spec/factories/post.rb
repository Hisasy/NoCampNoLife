FactoryBot.define do
  factory :post do
    main_title { Faker::Lorem.characters(number: 10) }
    # date { Faker::Lorem.characters(number: 20) }
    location { Faker::Lorem.characters(number: 8) }
    sub_title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 50) }

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/test.png'), filename: 'test.jpg')
    end
  end
end