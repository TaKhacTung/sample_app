class ApplicationController < ActionController::Base
    def hello
        render html:"Hello,Hello"
    end  
    before_action :set_locale
  #  def set_locales
 #       I18n.locale = params[:locale] || I18n.default_locale
  #  end
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
  end
  def price
    price = 100000
  end        
end
