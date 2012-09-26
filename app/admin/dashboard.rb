ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => "Dashboard"

  content :title => "Dashboard" do
    columns do
      column do
        panel "Recent Users" do
          ul do
            User.limit(10).order('created_at desc').collect do |user|
              li link_to(user.name, admin_user_path(user))
            end
          end
        end
      end
    end
  end

end
