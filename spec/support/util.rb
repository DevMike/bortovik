def click_autocomplete(link_text)
  page.driver.browser.execute_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
end

def fill_in_attributes(field_pattern, attributes, fields = nil)
  fields ||= attributes.keys
  fields = Array(fields)
  fields.each do |field|
    field_name = field_pattern.gsub("%{field}", field.to_s)
    fill_in(field_name, :with => attributes[field])
  end
end

def reset_locale
  I18n.locale = :en
  visit root_path(:locale => 'en')
end

RSpec::Matchers.define :have_select_options do
  match do |select, options|
    options.each do |option|
      page.has_xpath("//select[@id='#{select}']/option[@value='#{option}']")
    end
  end
end


RSpec::Matchers.define :be_visible_after_delay do
  match do |element|
    begin
      wait_until { element.visible? }
      true
    rescue Capybara::TimeoutError
      false
    end
  end
end

def wait_until
  require "timeout"
  Timeout.timeout(Capybara.default_wait_time) do
    sleep(0.1) until value = yield
    value
  end
end

def wait_for_ajax
  wait_until do
    page.evaluate_script 'jQuery.isReady&&jQuery.active==0'
  end
end
