require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecaptchaMailhide::URL do
  before do
    RecaptchaMailhide::Encrypt.stub(:encrypt).and_return("ABC")
  end

  describe ".url_for" do
    it("returns the proper URL") do
      RecaptchaMailhide::URL.url_for('foo@bar.com').should eq('https://www.google.com/recaptcha/mailhide/d?k=PUBLIC_KEY&c=ABC')
    end
  end
end
