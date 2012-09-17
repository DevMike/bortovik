ActiveAdmin.register Settlement do
  menu :label => 'Settlements', :parent => 'Locations', :priority => 3

  index do
    column :name
    column :russian_name
    default_actions
  end

  filter :russian_name
  filter :region, :as => :select, :collection => Region.order(:name).map(&:name)

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :russian_name
    end
    f.buttons
  end
end