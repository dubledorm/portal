class Grade < ApplicationRecord
  include GradeConstConcern
  include HumanAttributeValue

  # Grade(оценка) используются для оценки какого-то объекта.
  # Например выполненного заказа или Исполнителя зааказа
  # Может добавляться к любому объекту
  # Может быть разных типов. Например можно выставить оценку за качество реквизита и за содержаниен программы
  # Количество типов регулируется массивом GRADE_TYPES - его надо настроить под собственные нужды
  # Оценку может выставлять только зарегистрированный пользователь
  # На один объект одним пользоватеоем может быть выставлена только одна оценка одного типа
  # GRADE_RANGE - ограничивает максимальную выставляемую оценку (grade_value)
  # Соответственно нижняя треть диапазона считается отрицательной оценкой, верхняя треть положительной, середина нейтральной
  # Оценка может не выставляться, тогда поле grade_value надо оставить со значением nil

  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :user, uniqueness: { scope: [:object, :grade_type] }

  scope :by_grade_type, ->(grade_type){ where(grade_type: grade_type) }
  scope :by_object, ->(object_id, object_type){ where(object_id: object_id, object_type: object_type) }
end
