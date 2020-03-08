# encoding: UTF-8
module GradeConcern
  extend ActiveSupport::Concern

  # Концерн предоставляет возможность добавлять систему выставления оценок к любому объекту

  included do

    has_many :grades, as: :object
    has_many :grade_averages, as: :object


    scope :by_grade_type, ->(grade_type){ joins(:grades).where(grades: { grade_type: grade_type }) }
    scope :sort_by_grade, ->(grade_type, direction = :desc){ joins(:grade_averages).where(grade_averages: { grade_type: grade_type }).order(grade_value: direction) }
  end

  # Метод для пересчёта статистики по оценке объекта
  # Используется в сервисе Grade::RecalculateService. Обычно больше нигде на нужен.
  def average_grade(grade_type)
    sum = self.grades.by_grade_type(grade_type).sum(:grade_value)
    count = self.grades.by_grade_type(grade_type).count
    average = count > 0 ? sum / count : nil
    { average_grade: average,
      count: count
    }
  end
end
