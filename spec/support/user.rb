module UserMacros
  module Request
    def sign_in(user)
      before(:each) do
        @current_user = if user.is_a?(Symbol)
          FactoryGirl.create(user.to_sym)
        else
          user
        end
        login_as @current_user
      end
    end
  end

  module Controller
    def sign_in(user)
      before(:each) do
        @current_user = if user.is_a?(Symbol)
          FactoryGirl.create(user.to_sym)
        else
          user
        end
        sign_in @current_user
      end
    end
  end
end

def create_user_notifications(user, unread, read)
  FactoryGirl.create_list(:notification_read, read, :user=>user)
  FactoryGirl.create_list(:notification, unread, :user=>user)
end