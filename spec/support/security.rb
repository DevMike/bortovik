def should_raise_access_denied
  expect{ yield }.to raise_error(CanCan::AccessDenied)
end

def should_not_raise_access_denied
  expect{ yield }.to_not raise_error(CanCan::AccessDenied)
end

def should_raise_not_found
  expect{ yield }.to raise_error(ActiveRecord::RecordNotFound)
end

def should_raise_exception(exception)
  expect{ yield }.to raise_error(exception)
end

def should_not_edit_company_profile
  page.should_not have_link 'Edit company profile'
  should_raise_access_denied{ visit(edit_company_path) }
end
