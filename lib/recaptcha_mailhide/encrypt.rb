require 'openssl'
require 'base64'

module RecaptchaMailhide
  module Encrypt
    BLOCK_SIZE = 16
    INITIALIZATION_VECTOR = 0.chr * 16

    # Encrpyts the given string using AES 128 and
    # returns the result in URL-safe Base64 form.
    #
    def self.encrypt(string)
      aes = build_aes
      urlsafe_base64(aes.update(pad_string(string)) + aes.final)
    end

    private

    # Converts the given string to Base64 encoding,
    # replacing '+' with '-', '/' with '_' and
    # removing newlines in order to make it URL-safe.
    #
    def self.urlsafe_base64(string)
      Base64.encode64(string).tr('+/', '-_').gsub("\n", '')
    end

    # Pads the given string to blocks of 16 bytes
    # using bytes representing the number of bytes
    # used for padding.
    #
    def self.pad_string(string)
      padding = BLOCK_SIZE - (string.length % BLOCK_SIZE)
      string + padding.chr * padding
    end

    # Initializes the cipher.
    #
    def self.build_aes
      aes = OpenSSL::Cipher::Cipher.new("aes-128-cbc")
      aes.encrypt
      aes.iv = INITIALIZATION_VECTOR
      aes.padding = 0

      aes.key = binary_public_key

      aes
    end

    # Returns the private key converted from hex
    # to binary.
    #
    def self.binary_public_key
      RecaptchaMailhide.configuration.private_key.unpack('a2' * 16).map {|x| x.hex }.pack('c' * 16)
    end
  end
end
