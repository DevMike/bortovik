#require 'spec_helper'
#require 'requests/shared_examples/char_counter'
#require 'requests/shared_examples/delete_image'
#
#describe "Company" do
#  context "as account owner" do
#    sign_in(:user)
#
#    context "edit profile" do
#      before(:each) { visit(edit_company_path) }
#
#      it "attributes" do
#        company_fields = [:name, :email, :phone, :fax, :street, :city, :state, :postal_code, :country, :website, :employees, :market, :raw_description, :imprint_url, :imprint_text]
#
#        visit(edit_company_path)
#
#        new_company_attributes = FactoryGirl.attributes_for("company_another")
#        new_company_attributes[:description] = new_company_attributes[:description]*999
#        new_company_attributes[:country] = 'UA'
#        new_company_attributes[:employees] = 'over 1000 employees'
#        new_company_attributes[:market] = 'International'
#        select_boxes = [:country,:employees,:market]
#
#        within("#edit_company") do
#          company_fields.reject{|c| select_boxes.include?(c)}.each do |field|
#            fill_in("company_#{field}", :with=>new_company_attributes[field])
#          end
#          select('Ukraine', :from => 'company_country')
#          select('over 1000 employees', :from => 'company_employees')
#          select('International', :from => 'company_market')
#        end
#
#        click_on('Save changes')
#
#        #the values should be set in accordance with the options in the factory
#        new_company_attributes[:employees] = 'over_1000'
#        new_company_attributes[:market] = 'international'
#        company_fields.each do |field|
#          find("#company_#{field}").value.should eql(new_company_attributes[field])
#        end
#      end
#
#      #@TODO need to figure out why the test is float on staging
#      pending "upload logo", :js => true   do
#        file_delete('company', 'logo', @current_user.company.id)
#
#        visit(edit_company_path)
#        click_on('Information')
#
#        attach_file('company_logo', Rails.root + 'spec/factories/images/company_logo.png')
#        click_on('Save changes')
#        #@TODO need to find better solution
#        sleep 5
#        file_exists?('company', 'logo', @current_user.company.id).should be_true
#      end
#
#      context "delete logo", :js => true do
#        it_behaves_like "delete image" do
#          before(:all) do
#            @model = 'company'
#            @file_field = 'logo'
#            @success_message = 'Successfully updated company info'
#          end
#
#          before do
#            click_on('Information')
#            attach_file('company_logo', Rails.root + 'spec/factories/images/company_logo.png')
#            click_link 'Delete logo'
#          end
#        end
#      end
#
#      it "shows flash alert on error"  do
#        fill_in 'Company name', :with => ''
#        click_on('Save changes')
#        page.should have_content(I18n.t('flash.actions.update.alert'))
#      end
#
#      it "opens tab with first error", :js => true  do
#        click_on('Information')
#        select('', :from => 'Employees')
#        click_on('Settings')
#        select('', :from => 'Rating categories set')
#        click_on('Save changes')
#        find('#information').should be_visible
#        find('#settings').should_not be_visible
#      end
#    end
#
#    it "delete company account", :js => true  do
#      FactoryGirl.create(:member, :company=>@current_user.company)
#
#      visit(company_path)
#
#      click_on('Delete Company Account')
#
#      within('#dialog') do
#        find('input[@name=commit]')['disabled'].should eq("true")
#
#        check('confirm_delete_company')
#        click_on('Delete Company Account')
#
#        #TODO move it to model level tests and refactor the spec to have clear acceptance test
#        @current_user.company.users.not_deleted.should be_empty
#        Company.not_deleted.exists?(:id => @current_user.company.id).should be_false
#      end
#    end
#
#    context "categories", :js => true do
#      before(:each) do
#        visit(edit_company_path)
#        click_on('Information')
#      end
#
#      it "should show at least one category field" do
#        @current_user.company.categories = []
#        @current_user.company.save(:validate=>false)
#
#        visit(edit_company_path)
#
#        within('#company_categories') do
#          all('input[type=text]').count.should eq(2)
#        end
#      end
#
#      it "should not allow to add more then max limit" do
#        find('#company_categories .add_child').should be_visible
#
#        (Settings.company.max_categories - 1).times{click_on('Add category')}
#
#        find('#company_categories .add_child').should_not be_visible
#      end
#
#      it "should be able to add" do
#        within('#company_categories') do
#          click_on('Add category')
#        end
#
#        all('#company_categories > div.input input[type=text]').last().set('some new category')
#
#        click_on('Save changes')
#
#        all('#company_categories > div.input input[type=text]').map{|element| element.value}.should eq(['Category', 'some new category'])
#      end
#
#      context "be able to delete" do
#        before(:each) do
#          @current_user.company.categories << FactoryGirl.create(:another_category)
#          visit(edit_company_path)
#          click_on('Information')
#        end
#
#        it "by link" do
#          within('#company_categories') do
#            click_on('delete')
#          end
#
#          click_on('Save changes')
#          click_on('Information')
#
#          all('#company_categories > div.input input[type=text]').map{|element| element.value}.should eq(['Category'])
#        end
#
#        it "by clearing field" do
#          within('#company_categories') do
#            fill_in 'Category', :with=>''
#          end
#
#          click_on('Save changes')
#          click_on('Information')
#
#          all('#company_categories > div.input input[type=text]').map{|element| element.value}.should eq(['Category'])
#        end
#      end
#    end
#
#    context "properties", :js => true do
#      before(:each) do
#        visit(edit_company_path)
#        click_on('Information')
#      end
#
#      it "should show at least one property" do
#        property_elements.count.should == 2
#      end
#
#      it "should be able to add" do
#        new_properties = %w(property1 value1 property2 value2)
#
#        within('#company_properties') do
#          click_on('Add custom category')
#        end
#
#        property_elements.each_with_index{ |element, index| element.set(new_properties[index]) }
#
#        click_on('Save changes')
#
#        property_elements.map{|element| element.value}.should eq(new_properties)
#      end
#
#      context "be able to delete" do
#        before(:each) do
#          @current_user.company.properties << FactoryGirl.create_list(:sequence_property, 2, :company => @current_user.company)
#          @last_property_array = [@current_user.company.properties.last.name, @current_user.company.properties.last.value]
#          visit(edit_company_path)
#          click_on('Information')
#        end
#
#        it "by link" do
#          within('#company_properties') do
#            click_on('delete')
#          end
#
#          click_on('Save changes')
#          click_on('Information')
#
#          property_elements.map{|element| element.value}.should eq(@last_property_array)
#        end
#
#        it "by clearing field" do
#          properties = property_elements
#          properties[0].set('')
#          properties[1].set('')
#
#          click_on('Save changes')
#
#          property_elements.map{|element| element.value}.should eq(@last_property_array)
#        end
#      end
#
#      def property_elements
#        all('#company_properties > div.item div.column input[type=text]')
#      end
#    end
#
#    context "representatives", :js => true do
#      it "displays 'not representatives yet' info" do
#        visit edit_company_path
#        page.should have_content('There are no representatives for your company yet.')
#      end
#
#      context "list" do
#        before(:each) do
#          @member = FactoryGirl.create :member, :company => @current_user.company,
#                                                :first_name => 'John',
#                                                :last_name => 'Doe'
#
#          visit edit_company_path
#          click_on 'Representatives'
#          click_on 'Add or remove representatives'
#          within '#representatives_dialog' do
#            check 'John Doe'
#            click_button 'Update'
#          end
#        end
#
#        it "selects members as representatives" do
#          member_should_be_in_representative_list
#        end
#
#        it "saves selected members as representatives" do
#          within '#edit_company' do
#            click_button 'Save changes'
#          end
#
#          click_on 'Representatives'
#
#          page.should have_content('Successfully updated company info')
#          member_should_be_in_representative_list
#        end
#
#        def member_should_be_in_representative_list
#          within '#edit_company ul.representatives' do
#            representative = find :id, ActionController::RecordIdentifier.dom_id(@member, :representative)
#            representative.should be_visible
#          end
#        end
#      end
#    end
#
#    context "widget preview" do
#      it "should see widget code if subscription plan allows" do
#        Subscription.any_instance.stub(:widget?).and_return{true}
#        visit tools_company_path
#        page.should have_content('Widget Preview')
#      end
#
#      it "should not see widget code if subscription plan allows" do
#        Subscription.any_instance.stub(:widget?).and_return{false}
#        visit company_path
#        page.should_not have_content('Widget Preview')
#      end
#    end
#
#    context "rate criteria category", :js => true do
#      before do
#        @category = FactoryGirl.create(:rate_criteria_category, :name => 'Hotels')
#        @rate_criterias = FactoryGirl.create_list(:rate_criteria, 3, :rate_criteria_category => @category)
#
#        visit(edit_company_path)
#        click_on('Settings')
#      end
#
#      it "should be able to preview" do
#        select('Hotels', :from => 'company_rate_criteria_category_id')
#        within('#rate_criteria_category ul') do
#          @rate_criterias.each do |rc|
#            page.should have_content(rc.name)
#          end
#        end
#      end
#
#      it "should not allow to edit global category" do
#        select('Hotels', :from => 'company_rate_criteria_category_id')
#        within('#rate_criteria_category') do
#          find_link('Edit').should_not be_visible
#        end
#      end
#
#      it "should allow to edit custom category" do
#        select(RateCriteriaCategory::CUSTOM, :from => 'company_rate_criteria_category_id')
#        within('#rate_criteria_category') do
#          find_link('Edit').should be_visible
#        end
#      end
#    end
#
#    context "custom rate criterias", :js => true do
#      before do
#        visit edit_company_path
#        click_on 'Settings'
#      end
#
#      it "should allow to edit" do
#        select(RateCriteriaCategory::CUSTOM, :from => 'company_rate_criteria_category_id')
#
#        within('#edit_custom_rate_criterias') do
#          fill_in 'Criteria', :with => 'my criteria'
#          click_on 'Update'
#        end
#
#        within('#rate_criteria_category') do
#          page.should have_content('my criteria')
#        end
#      end
#
#      it "should allow to add" do
#        @current_user.company.custom_rate_criteria_category.rate_criterias.create(:name => 'my first criteria')
#
#        select(RateCriteriaCategory::CUSTOM, :from => 'company_rate_criteria_category_id')
#
#        within('#edit_custom_rate_criterias') do
#          click_on 'add criteria'
#          all('input[type=text]')[1].set('my second criteria')
#          click_on 'Update'
#        end
#
#        within('#rate_criteria_category') do
#          page.should have_content('my first criteria')
#          page.should have_content('my second criteria')
#        end
#      end
#
#      it "should allow to delete" do
#        %w(first second).each_with_index do |criteria, index|
#          @current_user.company.custom_rate_criteria_category.rate_criterias.create(:name => criteria, :position => index)
#        end
#
#        select(RateCriteriaCategory::CUSTOM, :from => 'company_rate_criteria_category_id')
#
#        within('#edit_custom_rate_criterias') do
#          click_on 'delete'
#          click_on 'Update'
#        end
#
#        within('#rate_criteria_category') do
#          page.should have_content('first')
#          page.should_not have_content('second')
#        end
#      end
#    end
#
#    context "discount info" do
#      it "should not display discount info if subscription has not discount" do
#        visit company_path
#        page.should_not have_css('.discount_info')
#      end
#
#      it "should display discount inactive message when discount has run out", :js => true do
#        stub_subscription_and_discount(Date.today - 1.month, 1)
#        visit company_path
#
#        within('.discount_info') do
#          page.should have_content('The discount code you have used is expired.')
#        end
#      end
#
#      it "should display discount info for next months if available" do
#        stub_subscription_and_discount(Date.today, 2)
#        visit company_path
#
#        within('.discount_info') do
#          page.should have_content('You are using the discount code discount_code: For the next 1 month(s) you are paying a reduced price of 14.5 EUR.')
#        end
#      end
#
#      it "should display discount info for current months if last month" do
#        stub_subscription_and_discount(Date.today, 1)
#
#        visit company_path
#
#        within('.discount_info') do
#          page.should have_content('You are using the discount code discount_code: This month you paid a reduced price of 14.5 EUR.')
#        end
#      end
#
#      def stub_subscription_and_discount(start_date, month_count)
#        Subscription.any_instance.stub(:paid_plan?).and_return{ true }
#        Subscription.any_instance.stub(:start_date).and_return{start_date}
#        Subscription.any_instance.stub(:discount).and_return{ FactoryGirl.build(:discount, :month_count => month_count)}
#        Discount.any_instance.stub(:code).and_return('discount_code')
#      end
#    end
#
#    context "virtual phone" do
#      it "displays virtual phone when set" do
#        Company.any_instance.stub(:virtual_phone).and_return{ '44-44-44' }
#        visit edit_company_path
#        within('section.virtual_phone') do
#          page.should have_content('44-44-44')
#        end
#      end
#
#      it "should not display section if no virtual phone set" do
#        Company.any_instance.stub(:virtual_phone).and_return{ nil }
#        visit edit_company_path
#        page.should_not have_css('section.virtual_phone')
#      end
#
#    end
#  end
#
#  context "as company member" do
#    sign_in(:member)
#
#    it "not be able to edit company's info" do
#      should_not_edit_company_profile
#    end
#
#    it "not be able to view company account" do
#      should_raise_access_denied{ visit(company_path) }
#    end
#  end
#
#  context "review" do
#    sign_in(:user)
#
#    it "regenerates the short link", :js => true do
#      Company.any_instance.stub(:generate_short_name).and_return('xXxX')
#
#      visit tools_company_path
#
#      within '#company_rating' do
#        click_on 'Regenerate'
#      end
#
#      within '#rating_dialog' do
#        check('Yes, I want to regenerate the link.')
#        click_on 'Regenerate'
#      end
#
#      wait_for_ajax
#
#      page.should have_content('The link was successfully changed.')
#      find('#short_name_link').value.should include('/r/xXxX')
#    end
#  end
#end
