FactoryGirl.define do
  factory :user_parameter, class: UserParameter do |au|
    description "description"
    user
  end
end