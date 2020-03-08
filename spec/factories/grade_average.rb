FactoryGirl.define do
  factory :grade_average, class: GradeAverage do |grade_average|
    grade_value 8
    grade_type 'quality'
    grade_average.association :object, factory: :blog
  end
end