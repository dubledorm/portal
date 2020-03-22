# encoding: utf-8
class GradesController < ApplicationController

  has_scope :by_grade_type, as: :grade_type
  has_scope :by_object, as: :object, using: %i[object_id object_type], type: :hash

  def index
    check_parameters
    super
  end

  def new
    check_parameters
    super do
      @resource = Grade.new(grade_type: params[:grade_type],
                            user_id: params.required(:user_id),
                            object_id: params[:object][:object_id],
                            object_type: params[:object][:object_type])
    end
  end

  def create
    super do
      ActiveRecord::Base.transaction do
        @resource = Grade.create(grade_params)
        unless @resource.persisted?
          render :new
          return
        end
        Grade::RecalculateService::new(@resource).call
      end
      redirect_to grade_path(@resource)
    end
  end

  def update
    super do
      ActiveRecord::Base.transaction do
        @resource.update(grade_params)
        if @resource.errors.count > 0
          render :edit
          return
        end
        Grade::RecalculateService::new(@resource).call
      end
      redirect_to grade_path(@resource)
    end
  end

  private

  def grade_params
    params.required(:grade).permit(:grade_value, :grade_type, :content, :object_id, :object_type, :user_id)
  end

  def check_parameters
    raise ActionController::ParameterMissing, 'Parameter grade_type should be defined' unless params.has_key?(:grade_type)
    raise ActionController::ParameterMissing, 'Parameter object should be defined' unless params.has_key?(:object)
    raise ActionController::ParameterMissing,
          'Parameter object should be { object_id: value_id, object_type: value_type}' unless params[:object].has_key?(:object_id) && params[:object].has_key?(:object_type)
  end
end
