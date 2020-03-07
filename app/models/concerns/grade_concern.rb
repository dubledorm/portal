# encoding: UTF-8
module GradeConcern
  extend ActiveSupport::Concern

  # Концерн предоставляет возможность добавлять систему выставления оценок к любому объекту

  included do

    has_many :grades, as: :object

    scope :by_grade_type, ->(grade_type){ joins(:grades).where(grades: { grade_type: grade_type }) }
  end

  def average_grade(grade_type)
    sum = self.grades.by_grade_type(grade_type).sum(:grade_value)
    count = self.grades.by_grade_type(grade_type).count
    average = count > 0 ? sum / count : nil
    { average_grade: average,
      count: count
    }
  end
end
