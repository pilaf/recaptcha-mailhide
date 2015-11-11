require 'recaptcha_mailhide/helpers/action_view_helper'

module RecaptchaMailhide
  class Railtie < ::Rails::Railtie # :nodoc:
    initializer 'recaptcha-mailhide' do
      ::ActionView::Base.send :include, RecaptchaMailhide::ActionViewHelper
    end
  end
end
