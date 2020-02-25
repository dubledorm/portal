FactoryGirl.define do
  factory :tag, class: Tag do
    sequence(:tag_type) { |n| "tag_type#{n}" }
    sequence(:name) { |n| "name#{n}" }
  end
end