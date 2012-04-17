$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'recaptcha_mailhide'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
end

RecaptchaMailhide.configure do |config|
  config.private_key = "deadbeefdeadbeefdeadbeefdeadbeef"
  config.public_key = "PUBLIC_KEY"
end
