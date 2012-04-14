I18n.locale = Bortovik::Application.config.i18n.default_locale
ActiveAdmin.application.unload!
Rails.application.reload_routes!