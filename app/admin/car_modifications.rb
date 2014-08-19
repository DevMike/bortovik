ActiveAdmin.register CarModification do
  menu :label => 'Car Modifications', :parent => 'Cars', :priority => 3

  # filter :car_brand, :as => :select, :collection => CarBrand.order(:name).map{|cb| [cb.name, cb.id] }
  filter :car_model, :as => :select, :collection => proc{ CarModel.
      where(params[:q] && params[:q][:car_brand_eq].present? ? ["#{CarModel.table_name}.car_brand_id = ?", params[:q][:car_brand_eq]] : "").
      order(:name).map(&:name) }

  index do
    column :name
    column :car_model
    column :car_brand
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
      f.input :description, :as => :ckeditor
    end
    f.buttons
  end
end
