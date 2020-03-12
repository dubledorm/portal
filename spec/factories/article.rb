FactoryGirl.define do

  factory :article, class: Article do |s|
    sequence(:name){|n| "article#{n}" }
    article_type :service
    state :active

    user
  end
end