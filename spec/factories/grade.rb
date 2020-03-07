FactoryGirl.define do
  factory :grade_without_value, class: Grade do |grade|
    grade_type 'quality'
    grade.association :object, factory: :blog
    user
  end

  factory :grade, parent: :grade_without_value do
   grade_value 8
  end
end