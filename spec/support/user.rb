module UserMacros
  module Request
    def sign_in(user, scope=:user)
      before(:each) do
        @current_user = if user.is_a?(Symbol)
                          FactoryGirl.create(user.to_sym)
                        else
                          user
                        end
        login_as @current_user, :scope => scope
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
