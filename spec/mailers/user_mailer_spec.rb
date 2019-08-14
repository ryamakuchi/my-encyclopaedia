require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  describe "POST devise/registrations#create" do
    let!(:mail_address) { Faker::Internet.free_email }
    let!(:user) { create(:user, email: mail_address) }
    let!(:send_mail) { ActionMailer::Base.deliveries.last }

    it "メールが送信されていること" do
      expect(send_mail.to).to eq [mail_address]
      expect(send_mail.from).to  eq ["noreply@my-encyclopaedia.jp"]
      expect(send_mail.subject).to eq "メールアドレス確認メール"
      expect(send_mail.body).to match "#{user.email}様"
      expect(send_mail.body).to match "以下のリンクをクリックし、メールアドレスの確認手続を完了させてください。"
    end
  end
end
