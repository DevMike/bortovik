ActiveAdmin.register User do
  actions :all, :except => :new

  filter :email
  filter :name
  #filter :country, :as => :select, :collection => Country.order(:name).map(&:name)
  #filter :region, :as => :select, :collection => Region.order(:name).map(&:name)
  filter :settlement, :as => :select, :collection => Settlement.order(:name).map(&:name)

  scope :all, :default => true
  scope :confirmed
  scope :unconfirmed

  #@TODO: ability logging as a user from the admin part
  #member_action :login, :method => :get do
  #  user = User.find(params[:id])
  #  sign_in(user, :bypass => true)
  #  redirect_to dashboard_url, :notice => "You have logged as #{user}"
  #end

  index do
    column :id
    column :email
    column :name
    [:country, :region, :settlement].each do |location|
      column location do |user|
        link_to user.send(location).name, send("admin_#{location}_path", user.send(location))
      end
    end
    column :preferred_currency

    default_actions
  end

  show do
    attributes_table_for user do
      rows :id, :name, :email, :country, :region, :settlement
    end
  end

  form do |f|
    f.inputs "User Details" do
      [:name, :email, :preferred_currency].each{|attr| f.input attr }
      f.input :settlement, :as => :select
    end
    f.buttons
  end
end
