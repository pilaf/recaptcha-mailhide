require 'openssl'
require 'base64'

module RecaptchaMailhide
  module Encrypt
    BLOCK_SIZE = 16
    INITIALIZATION_VECTOR = 0.chr * 16

    def self.encrypt(string)
      aes = build_aes
      encrypted = aes.update(pad_string(string)) + aes.final
      urlsafe_base64(encrypted)
    end

  private

    def self.urlsafe_base64(string)
      Base64.encode64(string).tr('+/', '-_').chomp
    end

    def self.pad_string(string)
      padding = BLOCK_SIZE - (string.length % BLOCK_SIZE)
      string + padding.chr * padding
    end

    def self.build_aes
      aes = OpenSSL::Cipher::Cipher.new("aes-128-cbc")
      aes.encrypt
      aes.iv = INITIALIZATION_VECTOR
      aes.padding = 0

      # Convert the private key from hex to binary
      aes.key = RecaptchaMailhide.configuration.private_key.unpack('a2' * 16).map {|x| x.hex }.pack('c' * 16)

      aes
    end
  end
end
