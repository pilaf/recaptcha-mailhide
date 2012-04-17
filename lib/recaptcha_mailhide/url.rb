module RecaptchaMailhide
  module URL
    BASE_URL = "http://www.google.com/recaptcha/mailhide/d"

    def self.url_for(email)
      public_key = RecaptchaMailhide.configuration.public_key
      encrypted_email = RecaptchaMailhide::Encrypt.encrypt(email)
      BASE_URL + "?k=#{public_key}&c=#{encrypted_email}"
    end
  end
end
