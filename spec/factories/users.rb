# Example
#FactoryGirl.define do
#  factory :user do
#    company
#    first_name 'Martin'
#    last_name 'Paranoid'
#    salutation 'mr'
#    sequence(:email) {|n| "user#{n}@example.com" }
#    country 'DE'
#    timezone 'Berlin'
#    password '123456'
#    password_confirmation '123456'
#    title ''
#    office_phone ''
#    mobile_phone ''
#    fax ''
#    photo ''
#    company_approved true
#    confirmed_at Time.now
#    roles [:admin]
#
#    factory :unapproved_member do
#      company_approved false
#      roles [:member]
#    end
#
#    factory :member do
#      roles [:member]
#    end
#
#    factory :admin do
#      roles [:admin]
#    end
#
#    factory :process_starter do
#      roles [:process_starter]
#    end
#
#    factory :representative do
#      representative true
#    end
#
#    factory :frau do
#      salutation 'mrs'
#    end
#
#    factory :user_another do
#      sequence(:email) {|n| "user_another-#{n}@example.com" }
#      association :company, :factory=>:company_another
#      timezone 'UTC'
#      title 'owner'
#      office_phone '123456'
#      mobile_phone '123456'
#      fax '123456'
#      locale 'de'
#    end
#
#    factory :user_to_invite do
#      sequence(:email) {|n| "user_to_invite-#{n}@example.com" }
#      sequence(:invitation_token) {|n| "user_to_invite#{n}" }
#      association :invited_by, :factory => :user
#      password ''
#      company_approved false
#      confirmed_at nil
#      roles []
#    end
#
#    factory :invited_user do
#      sequence(:email) {|n| "invited_user-#{n}@example.com" }
#      sequence(:invitation_token) {|n| "invited_user#{n}" }
#      association :invited_by, :factory => :user
#    end
#
#    factory :user_to_invite_another do
#      sequence(:email) {|n| "user_to_invite_another-#{n}@example.com" }
#      association :company, :factory=>:company_another
#      association :invited_by, :factory => :user
#      password ''
#      company_approved false
#      confirmed_at nil
#      roles []
#    end
#
#    factory :invited_user_another do
#      sequence(:email) {|n| "invited_user_another-#{n}@example.com" }
#      association :company, :factory=>:company_another
#      association :invited_by, :factory => :user
#    end
#
#    factory :deleted_user do
#      deleted_at DateTime.now
#    end
#
#    factory :consumer, :class => User do
#      company nil
#      company_approved false
#      first_name 'Martin'
#      last_name 'Paranoid'
#      country 'DE'
#      timezone 'Berlin'
#      sequence(:email) {|n| "consumer#{n}@example.com" }
#      password '123456'
#      password_confirmation '123456'
#      confirmed_at Time.now
#      roles [:consumer]
#    end
#
#    factory :reviewer do
#      company nil
#      company_name 'My company'
#      roles [:consumer]
#    end
#  end
#
#end
