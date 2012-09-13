require 'requests/shared_examples/char_counter'

describe "Home" do
  context "contact message" do
    def contact_message_field(attr)
      "#contact_message_#{attr}"
    end

    before(:all) do
      @contact_message_attributes = FactoryGirl.attributes_for(:contact_message)
      @message_attributes = [:description, :subject]
      @user_attributes = [:email, :name]
    end

    context "signed in" do
      sign_in(:user)

      it "user data should be pre-filled and readonly" do
        visit contact_path
        @user_attributes.each do |attr|
          field = find contact_message_field(attr)
          field['value'].should == @current_user[attr]
          field['readonly'].should == 'readonly'
        end

        @message_attributes.each do |attr|
          find(contact_message_field(attr))['readonly'].should_not == 'readonly'
        end
      end
    end

    context "not signed in" do
      it "user attributes should not be readonly" do
        visit contact_path
        @user_attributes.each do |attr|
          find(contact_message_field(attr))['readonly'].should_not == 'readonly'
        end
      end
    end

    context "success" do
      it "should send and show a message" do
        visit contact_path
        within('#new_contact_message') do
          @contact_message_attributes.each_key do |attr|
            fill_in "contact_message_#{attr}", :with => @contact_message_attributes[attr]
          end
        end
        submit_form

        page.should have_content(I18n.t(:'home.contact_message.greetings'))
      end
    end

    context "errors" do
      before { visit contact_path }

      it "should validate form" do
        submit_form
        all('.error').count.should eq(3)
      end

      context "keeping values" do
        shared_examples_for "keep values when errors are" do
          it "should keep values" do
            within('#new_contact_message') do
              @attributes.each do |attr|
                fill_in "contact_message_#{attr}", :with => @contact_message_attributes[attr]
              end
            end
            submit_form

            @attributes.each do |attr|
              find(contact_message_field(attr))['value'].gsub(/\n/,'').should == @contact_message_attributes[attr]
            end
          end
        end

        context "user attributes" do
          it_behaves_like "keep values when errors are" do
            before { @attributes = @user_attributes }
          end
        end

        context "message attributes" do
          it_behaves_like "keep values when errors are" do
            before { @attributes = @message_attributes }
          end
        end
      end
    end

    it_behaves_like "char counter" do
      before(:all) do
        @form_selector = '#new_contact_message'
        @field = 'contact_message_description'
        @char_limit = 1000
        @new_description = '1'*1001
        @submit = 'Submit'
      end
      before{ visit contact_path }
    end
  end
end
