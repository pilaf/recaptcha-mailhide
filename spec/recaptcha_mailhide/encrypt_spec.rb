require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RecaptchaMailhide::Encrypt do
  describe ".encrypt" do
    it("properly encrypts x@example.com") do
      expect(RecaptchaMailhide::Encrypt.encrypt("x@example.com")).to eq("wBG7nOgntKqWeDpF9ucVNQ==")
    end

    it("properly encrypts johndoe@example.com") do
      expect(RecaptchaMailhide::Encrypt.encrypt("johndoe@example.com")).to eq("whWIqk0r4urZ-3S7y7uSceC9_ECd3hpAGy71E2o0HpI=")
    end

    it("properly encrypts long emails") do
      expect(RecaptchaMailhide::Encrypt.encrypt("this.sure.is.a.very.long.email.address@example.com")).to eq("Ax_miTfkXPP_jPPoe130TlwgEaiBCPUuCxaJy3KalZsWP8_Z_Qcc1Awpwk-cPjVvnsbi6P6Bf_de2U1A5aocVA==")
    end
  end
end
