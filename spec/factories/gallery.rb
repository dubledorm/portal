FactoryGirl.define do
  factory :gallery, :class=>Gallery do |s|
    sequence(:name) {|n| "gallery_name#{n}" }
    state 'active'
    user
  end
end
