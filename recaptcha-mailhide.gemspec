$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "recaptcha_mailhide/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "recaptcha-mailhide"
  s.version     = RecaptchaMailhide::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pedro Fayolle"]
  s.email       = ["pfayolle@gmail.com"]
  s.homepage    = "http://github.com/pilaf/recaptcha-mailhide"
  s.summary     = "ReCAPTCHA Mailhide client"
  s.description = "Implementation of Google's ReCAPTCHA Mailhide API"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.rdoc']
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rspec', ['>= 0']
end
