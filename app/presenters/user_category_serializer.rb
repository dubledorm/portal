class UserCategorySerializer
  include ActiveModel::Serializers::JSON

  attr_accessor :categories

  class UCSerializerError < StandardError; end


  def initialize(model)
    @categories = get_categories_list(model)
  end

  # Разбирает JSON строку вида [{name:'',title:'',included:''},{}...]
  # возвращает массив хешей, содержащий только включенные категории
  def self.parse_string(json_string)
    begin
      JSON.parse(json_string, symbolize_names: true).find_all{ |item| item[:included] }
    rescue Exception => e
      raise UCSerializerError, 'parseString error: ' + e.message
    end
  end

  def attributes
    { categories: categories }
  end

  private

  def get_categories_list(model)
    result = []
    Tag.category.sort_by(&:title).each do |category|
      result << { name: category.name,
                  title: category.title,
                  included: model.has_category?(category.name) }
    end
    result
  end
end