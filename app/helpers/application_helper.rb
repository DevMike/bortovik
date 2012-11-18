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
end