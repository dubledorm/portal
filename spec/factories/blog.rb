FactoryGirl.define do
  factory :blog, class: Blog do
    post_type 'articul'
    sequence(:title) { |n| "title#{n}" }
    sequence(:content) { |n| "content#{n}" }
    seo_flag false
    state 'active'
    user
    gallery
  end
end