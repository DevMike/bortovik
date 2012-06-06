module ApplicationHelper
  def method_missing method_sym, *args, &block
    method_sym.to_s =~ /(.*?)_collection$/ ? model_collection($1) : super
  end

  def model_collection model
    model.camelize.constantize.all.map { |c| [c.name, c.id] }
  end

  def self.respond_to?(method_sym, include_private = false)
    method_sym.to_s =~ /(.*?)_collection$/ ? true : super
  end
end
