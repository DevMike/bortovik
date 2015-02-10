ActiveAdmin.register Settlement do
  menu :label => 'Settlements', :parent => 'Locations', :priority => 3

  index do
    column :name
    default_actions
  end

  filter :name
  # filter :region, :as => :select, :collection => Region.order(:name).map(&:name)

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.buttons
  end
end