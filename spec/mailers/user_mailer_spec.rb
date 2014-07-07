require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "password_send" do
    let(:mail) { UserMailer.password_send }

    it "renders the headers" do
      expect(mail.subject).to eq("Password send")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
