module RecaptchaMailhide
  module URL
    BASE_URL = "https://www.google.com/recaptcha/mailhide/d"

    def self.url_for(email_address)
      public_key = RecaptchaMailhide.configuration.public_key
      encrypted_address = Encrypt.encrypt(email_address)
      BASE_URL + "?k=#{public_key}&c=#{encrypted_address}"
    end
  end
end
