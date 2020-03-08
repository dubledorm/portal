class Grade
  class RecalculateService

    # Сервис пересчитывает среднюю оценку для объекта
    # Должен вызываться при добавлении, удалении и редактировании Grade

    def initialize(grade)
      @grade = grade
    end

    def call
      object = grade.object_type.constantize.find(grade.object_id) # Найти присоединённый объект
      average_sum = object.average_grade(grade.grade_type)         # Пересчитать статистику
      create_or_update(average_sum) # Сохранить статистику
    end

    private

    attr_accessor :grade

    def create_or_update(average_sum)
      grade_average = GradeAverage.by_object(grade.object_id, grade.object_type).by_grade_type(grade.grade_type).first
      if grade_average
        grade_average.update!(grade_value: average_sum[:average_grade],
                              grade_count: average_sum[:count])
      else
        GradeAverage.create!(object: grade.object,
                             grade_type: grade.grade_type,
                             grade_value: average_sum[:average_grade],
                             grade_count: average_sum[:count])
      end
    end
  end
end