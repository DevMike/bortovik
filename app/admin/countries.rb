ActiveAdmin.register Country do
  menu :label => 'Countries', :parent => 'Locations', :priority => 1

  index do
    column :name
    default_actions
  end

  filter :name

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :created_at, :updated_at
      end
    end

    panel 'Regions' do
      table_for(resource.regions) do |t|
        t.column(:name){|region| link_to region.name, admin_region_path(region) }
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