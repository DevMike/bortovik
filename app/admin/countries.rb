ActiveAdmin.register Country do
  menu :label => 'Countries', :parent => 'Locations', :priority => 1

  index do
    column :name
    column :russian_name
    default_actions
  end

  filter :russian_name

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :russian_name, :created_at, :updated_at
      end
    end

    panel 'Regions' do
      table_for(resource.regions) do |t|
        t.column(:russian_name){|region| link_to region.russian_name, admin_region_path(region) }
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :russian_name
    end
    f.buttons
  end
end