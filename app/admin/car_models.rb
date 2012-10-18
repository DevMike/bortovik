ActiveAdmin.register CarModel do
  menu :label => 'Car Models', :parent => 'Cars', :priority => 2

  index do
    column :name
    column :car_brand
    column do |m|
      link_to('Modifications', admin_car_modifications_path)
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
