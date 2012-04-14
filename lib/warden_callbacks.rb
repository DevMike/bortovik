Warden::Manager.after_set_user do |user, auth, opts|
  unless auth.request.cookies.has_key?('user')
    auth.cookies['user'] = Class.new.extend(HomeHelper).extend(ActionView::Helpers::TextHelper).dashboard_link_name(user)
  end
end

Warden::Manager.before_logout do |user,auth,opts|
  auth.cookies.delete 'user'
end