FactoryGirl.define do
  factory :user, class: User do |au|
    sequence(:email) {|n| "email#{n}@mail.ru" }
    au.password '12345678'
  end

  factory :user_with_services, parent: :user do |au|
    services { [ FactoryGirl.create(:service), FactoryGirl.create(:service, provider: 'github') ] }
  end

  factory :user_with_categories, parent: :user do |au|
    tags { [ FactoryGirl.create(:tag), FactoryGirl.create(:tag_category) ] }
  end
end