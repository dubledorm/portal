FactoryGirl.define do
  factory :tag, class: Tag do
    tag_type 'ordinal'
    sequence(:name) { |n| "name#{n}" }
  end
end