ActiveAdmin.register CarBrand do
  menu :label => 'Car Brands', :parent => 'Cars', :priority => 1

  index do
    column :name
    column do |m|
      link_to('Models', admin_car_models_path)
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.buttons
  end
end
