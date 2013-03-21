module CarsHelper
  def cars_list_select(list, resource)
    form = nil
    simple_form_for(:vehicle){|f| form = f}
    render partial: 'cars/input', locals: {f: form, car: resource, collection: list}
  end
end
