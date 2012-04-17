require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecaptchaMailhide::Encrypt do
  describe ".encrypt" do
    it("properly encrypts x@example.com") do
      RecaptchaMailhide::Encrypt.encrypt("x@example.com").should eq("wBG7nOgntKqWeDpF9ucVNQ==")
    end

    it("properly encrypts johndoe@example.com") do
      RecaptchaMailhide::Encrypt.encrypt("johndoe@example.com").should eq("whWIqk0r4urZ-3S7y7uSceC9_ECd3hpAGy71E2o0HpI=")
    end
  end
end
