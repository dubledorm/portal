class GradeAverage < ApplicationRecord
  include GradeConstConcern

  # GradeAverage(cредняя оценка)
  # Вычисляется на основании выставленных оценок Grade, с учётом типа оценки grade_type
  # Может добавляться к любому объекту
  # Количество типов регулируется массивом GRADE_TYPES - его надо настроить под собственные нужды
  # Вычисляется и создаётся с помощью ActiveJob после добавления, изменения, удаления Grade
  # На один объект может быть выставлена только одна оценка одного типа

  belongs_to :object, polymorphic: true

  validates :grade_type, uniqueness: { scope: [:object_type, :object_id] }

  scope :by_grade_type, ->(grade_type){ where(grade_type: grade_type) }
  scope :by_object, ->(object_id, object_type){ where(object_id: object_id, object_type: object_type) }


  def grades
    Grade.by_object(self.object_id, self.object_type).by_grade_type(self.grade_type).order(created_at: :desc)
  end
end
