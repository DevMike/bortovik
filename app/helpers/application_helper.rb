module ApplicationHelper
  def method_missing method_sym, *args, &block
    method_sym.to_s =~ /(.*?)_collection$/ ? model_collection($1) : super
  end

  def model_collection model
    collection_for model.camelize.constantize.all
  end

  def self.respond_to?(method_sym, include_private = false)
    method_sym.to_s =~ /(.*?)_collection$/ ? true : super
  end

  def collection_for(scope)
    scope.sort_by(&:name).map{ |c| [c.name, c.id] }
  end

  def smart_truncate(text, char_limit)
    char_limit = char_limit - 3 # take into account dots
    size = text.squish[0..char_limit].split.count - 1 #count spaces
    text.split.reject do |token|
      size += token.size
      size > char_limit
    end.join(" ").concat(text.size > char_limit ? "..." : "")
  end

  def link_to_profile(user)
    link_to(user.full_name, user_path(user))
  end

  def cars_list_select(list, resource)
    form = nil
    simple_form_for(:vehicle){|f| form = f}
    render partial: 'cars/input', locals: {f: form, car: resource, collection: list}
  end

  def render_car_brand
    brands = CarBrand.all
    models = brands.first.car_models
    modifications = models.first.car_modifications
    [[:car_brand, brands], [:car_model, models], [:car_modification, modifications]].map { |car| cars_list_select(car.last, car.first)}.join('').html_safe
  end
end
