ActiveAdmin.register Country do
  menu :label => 'Countries', :parent => 'Locations', :priority => 1

  index do
    column :name
    column :russian_name
    default_actions
  end

  filter :russian_name

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :russian_name
    end
    f.buttons
  end
end