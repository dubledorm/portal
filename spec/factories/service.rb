FactoryGirl.define do
  factory :service, class: Service do
    sequence(:uemail) { |n| "email#{n}@mail.ru" }
    provider 'facebook'
    sequence(:uid) { |n| n}
    sequence(:uname) { |n| "uname#{n}" }
    user
  end
end