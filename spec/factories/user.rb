FactoryGirl.define do
  factory :user, class: User do |au|
    sequence(:email) {|n| "email#{n}@mail.ru" }
    au.password '12345678'
  end
end