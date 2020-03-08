class GradeRecalculateJob < ApplicationJob
  queue_as :default

  rescue_from(Exception) do |exception|
    Rails.logger.error(exception.message)
  end

  def perform(grade)
    Grade::RecalculateService.new(grade).call
  end
end