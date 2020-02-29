FactoryGirl.define do
  factory :picture, :class=>Picture do |s|
    sequence(:name) {|n| "picture_name#{n}" }
    state 'active'
    gallery
  end
end
