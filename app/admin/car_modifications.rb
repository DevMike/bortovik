ActiveAdmin.register CarModification do
  menu :label => 'Car Modifications', :parent => 'Cars', :priority => 3

  index do
    column :name
    column :car_model
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.buttons
  end
end
