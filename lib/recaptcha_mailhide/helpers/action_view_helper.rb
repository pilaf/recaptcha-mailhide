module RecaptchaMailhide
  module ActionViewHelper
    # Generates a link tag to a ReCAPTCHA Mailhide URL for the given email
    # address.
    #
    # If a block is given it will use it to generate the content, and takes
    # these attributes:
    #
    # * +email+ - The email address to hide
    # * +options+ - See options below
    #
    # When no block is given it accepts two forms:
    #
    #   # Just email
    #   recaptcha_mailhide(email, options = {})
    #
    #   # Email and content
    #   recaptcha_mailhide(content, email, options = {})
    #
    # In the first instance it will process the email with
    # <code>truncate_email</code> and use it as the link content.
    #
    # ==== Options
    #
    # Accepts every option supported by <code>link_to</code>, plus:
    #
    # [:popup]
    #
    #   Set it to <code>true</code> to have the link open a popup window
    #   (through JavaScript and the <code>onclick</code> event).
    #
    #   Can also be a hash of sub-options, which can be <code>:width</code> and
    #   <code>:height</code>, setting the size of the popup window.
    #
    # In case of not supplying your own content you can also pass options for
    # <code>truncate_email</code>, e.g.:
    #
    #   recaptcha_mailhide('foo@example.com', omission: '-', truncate_domain: true)
    #
    def recaptcha_mailhide(*args, &block)
      options = args.extract_options!
      raise ArgumentError, "at least one argument is required (not counting options)" if args.empty?

      if block_given?
        url = RecaptchaMailhide.url_for(args.first)
        link_to(url, recaptcha_mailhide_options(url, options), &block)
      else
        if args.length == 1
          content = truncate_email(args.first, options)
          url = RecaptchaMailhide.url_for(args.first)
        else
          content = args.first
          url = RecaptchaMailhide.url_for(args.second)
        end
        link_to(content, url, recaptcha_mailhide_options(url, options))
      end
    end

    # Truncates an email address, e.g.:
    #
    #   truncate_email('example@example.com') # => e…@example.com
    #   truncate_email('example@example.com', truncate_domain: true) # => e…@e…
    #
    # ==== Options
    #
    # [:omission]
    #
    #   The string to use in replacement of the removed characters.
    #
    # [:truncate_domain]
    #
    #   Boolean. Whether to truncate the domain part of the address as well.
    #
    def truncate_email(email, options = {})
      return "" unless email.match(/@/)
      split_email = email.split('@')
      omission = options[:omission] || "…"
      local_part = "#{split_email.first.first}#{omission}"
      domain = options[:truncate_domain] ? "#{split_email.last.first}#{omission}" : split_email.last
      "#{local_part}@#{domain}"
    end

    private

    def recaptcha_mailhide_options(url, options)
      options.dup.tap do |o|
        if o[:popup]
          popup = o.delete(:popup)
          popup = popup.is_a?(Hash) ? popup.dup : {}
          popup.reverse_merge!(width: 500, height: 300)
          o[:onclick] = "window.open('#{url}', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=#{popup[:width]},height=#{popup[:height]}'); return false;"
        end
      end
    end
  end
end
