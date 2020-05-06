class UserCabinetPresenter

  include ActiveModel::Model

  attr_accessor :main_description, :main_image

  def errors_to_json
    errors.full_messages.join(', ')
  end

  def attributes
    {'main_description': main_description,
     'main_image': main_image
    }
  end

  def update(resource)
       ActiveRecord::Base.transaction do
        resource.update!({main_image: main_image}) unless main_image.nil?
        self.errors.merge!(resource.errors)

        return if main_description.nil?

        resource.create_user_parameter if resource.user_parameter.nil?
        user_parameter = resource.user_parameter
        user_parameter.update!({ description: main_description })
        self.errors.merge!(user_parameter.errors)
      end
  end
end