ActiveAdmin.register Tag do
  menu parent: :controls

  permit_params :name, :title, :tag_type

  form title: Tag.model_name.human do |f|
    f.semantic_errors *f.object.errors.keys
    inputs I18n.t('admin_menu.attributes') do
      f.input :tag_type, input_html: { value: 'ordinal' }, as: :hidden
      f.input :name
      f.input :title
    end
    f.actions
  end

  controller do

    def scoped_collection
      resource_class.ordinal
    end
  end
end
