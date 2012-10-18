ActiveAdmin.register Region do
  menu :label => 'Regions', :parent => 'Locations', :priority => 2

  index do
    column :name
    column :russian_name
    default_actions
  end

  filter :russian_name
  filter :country, :as => :select, :collection => Country.order(:name).map(&:name)

  show do
    panel 'Attributes' do
      attributes_table_for resource do
        rows :id, :name, :russian_name, :created_at, :updated_at
      end
    end

    panel 'Settlements' do
      table_for(resource.settlements) do |t|
        t.column(:russian_name){|settlement| link_to settlement.russian_name, admin_settlement_path(settlement) }
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