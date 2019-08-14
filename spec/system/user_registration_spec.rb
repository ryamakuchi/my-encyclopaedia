require "rails_helper"

RSpec.describe "POST devise/registrations#create", type: :system do
  describe "登録する情報が正しい場合" do
    let(:mail_address) { Faker::Internet.free_email }
    let(:password) { Faker::Internet.password(min_length: 6) }

    scenario "アカウント登録が成功する" do
      visit new_user_registration_path
      expect(page).to have_http_status :ok

      expect {
        fill_in "Eメール", with: mail_address
        fill_in "パスワード", with: password
        fill_in "パスワード（確認用）", with: password

        click_on "アカウント登録"
      }.to change(User, :count).by(1)

      expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      expect(current_path).to eq root_path

      expect(ActionMailer::Base.deliveries.last.to).to eq [mail_address]
    end
  end

  describe "登録する情報が正しくない場合" do
    scenario "アカウント登録が失敗する" do
      visit new_user_registration_path
      expect(page).to have_http_status :ok

      expect {
        fill_in "Eメール", with: ''
        fill_in "パスワード", with: ''
        fill_in "パスワード（確認用）", with: ''

        click_on "アカウント登録"
      }.to change(User, :count).by(0)

      expect(page).to have_content "Eメールを入力してください"
      expect(page).to have_content "パスワードを入力してください"
      expect(current_path).to eq '/users'
    end
  end
end
