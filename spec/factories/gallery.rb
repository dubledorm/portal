FactoryGirl.define do
  factory :gallery, :class=>Gallery do |s|
    sequence(:name) {|n| "gallery_name#{n}" }
    state 'active'
    user
  end

  factory :gallery_with_pictures, parent: :gallery do
    pictures { [ FactoryGirl.create(:picture), FactoryGirl.create(:picture) ] }
  end
end
