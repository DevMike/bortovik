ActiveAdmin.register CarFeature do
  menu :label => 'Car Features', :parent => 'Cars', :priority => 4

    filter :name
    # filter :car_feature_category, :as => :select, :collection => CarFeatureCategory.order(:name).map(&:name)

    index do
      column :name
      column :car_feature_category
      default_actions
    end

    show do
      panel 'Attributes' do
        attributes_table_for resource do
          rows :id, :name, :car_feature_category, :created_at, :updated_at
        end
      end
    end

    form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :car_feature_category
      end
      f.buttons
    end
  end
