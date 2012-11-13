ActiveAdmin.register CarBrand do
  menu :label => 'Car Brands', :parent => 'Cars', :priority => 1

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

    panel 'Models' do
      table_for(resource.car_models) do |t|
        t.column(:name){|model| link_to model.name, admin_car_model_path(model) }
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description, :as => :ckeditor
    end
    f.buttons
  end
end
