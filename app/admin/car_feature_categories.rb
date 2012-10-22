ActiveAdmin.register CarFeatureCategory do
  menu :label => 'Car Feature Categories', :parent => 'Cars', :priority => 4

  filter :name

  index do
    column :name
    default_actions
  end

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :created_at, :updated_at
      end
    end

    panel 'Car features' do
      table_for(resource.car_features) do |t|
        t.column(:name){|car_feature| link_to car_feature.name, admin_car_feature_path(car_feature) }
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
