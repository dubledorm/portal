module BaseConcern
  extend ActiveSupport::Concern

  def find_resource
    resource_class = controller_name.classify
    @resource = resource_class.constantize.find(params.required(:id))
  end

  def get_collection
    @collection = apply_scopes(controller_name.classify.constantize).all
  end

  def find_resource_by_params_mask(params_mask)
    params_store = {}
    params.keys.each do |key|
      unless params_mask.include?(key)
        params_store[key] = params[key]
        params.delete(key)
      end
    end
    find_resource
    params_store.keys.each do |key|
      params[key] = params_store[key]
    end
  end
end