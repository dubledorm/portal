FactoryGirl.define do
  factory :tag, class: Tag do
    tag_type 'ordinal'
    sequence(:name) { |n| "name#{n}" }
  end

  factory :tag_category, class: Tag do
    tag_type 'category'
    sequence(:name) { |n| "category#{n}" }
  end
end