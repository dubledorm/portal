class Grade < ApplicationRecord

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

  GRADE_TYPES = %w(quality interestingness politeness).freeze
  GRADE_RANGE = 10

  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :grade_type, presence: true, inclusion: { in: GRADE_TYPES }
  validates :user, uniqueness: { scope: [:object, :grade_type] }
  validates :grade_value, allow_nil: true, numericality: { greater_than: 0, less_than_or_equal_to: GRADE_RANGE, only_integer: true }
end
