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

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :car_brand, :created_at, :updated_at
      end
    end

    panel 'Modifications' do
      table_for(resource.car_modifications) do |t|
        t.column(:name){|modification| link_to modification.name, admin_car_modification_path(modification) }
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.buttons
  end
end
