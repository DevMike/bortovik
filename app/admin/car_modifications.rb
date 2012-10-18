ActiveAdmin.register CarModification do
  menu :label => 'Car Modifications', :parent => 'Cars', :priority => 3

  index do
    column :name
    column :car_model
    default_actions
  end

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :car_model, :created_at, :updated_at
      end
    end

    panel 'Features' do
      table_for(resource.car_feature_car_modifications) do |t|
        t.column(:name){|mapper| mapper.car_feature.name }
        t.column(:value){|mapper| mapper.value }
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
