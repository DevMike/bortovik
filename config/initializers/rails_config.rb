RailsConfig.setup do |config|
  config.const_name = "Settings"
end
# should be enabled later
#ActionMailer::Base.default_url_options[:host] = Settings.system.host
#ActionMailer::Base.default_url_options[:port] = Settings.system.port unless Settings.system.port.nil?
#ActionMailer::Base.default_url_options[:protocol] = Settings.system.protocol unless Settings.system.protocol.nil?
