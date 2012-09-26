ActiveAdmin.register Region do
  menu :label => 'Regions', :parent => 'Locations', :priority => 2

  index do
    column :name
    column :russian_name
    default_actions
  end

  filter :russian_name
  filter :country, :as => :select, :collection => Country.order(:name).map(&:name)

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :russian_name
    end
    f.buttons
  end
end