module RecaptchaMailhide
  class Configuration
    attr_writer :private_key, :public_key

    def private_key
      raise "RecaptchaMailhide's private_key is not set. If you're using Rails add an initializer to config/initializers." unless @private_key
      @private_key
    end

    def public_key
      raise "RecaptchaMailhide's public_key is not set. If you're using Rails add an initializer to config/initializers." unless @public_key
      @public_key
    end
  end
end
