require "rails_helper"

describe "POST devise/registrations#create", type: :system do
  context "登録する情報が正しい場合" do
    let(:email) { Faker::Internet.free_email }
    let(:pw) { Faker::Internet.password(min_length: 6) }

    scenario "アカウント登録が成功する" do
      visit new_user_registration_path
      expect(page).to have_http_status :ok

      fill_in "Eメール", with: email
      fill_in "パスワード", with: pw
      fill_in "パスワード（確認用）", with: pw

      expect { click_on "アカウント登録" }.to change(User, :count).by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq [email]

      expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      expect(current_path).to eq root_path
    end
  end

  context "登録する情報が正しくない場合" do
    scenario "アカウント登録が失敗する" do
      visit new_user_registration_path
      expect(page).to have_http_status :ok

      fill_in "Eメール", with: ''
      fill_in "パスワード", with: ''
      fill_in "パスワード（確認用）", with: ''

      expect { click_on "アカウント登録" }.to_not change(User, :count)

      mail = ActionMailer::Base.deliveries
      expect(mail).to eq []

      expect(page).to have_content "Eメールを入力してください"
      expect(page).to have_content "パスワードを入力してください"
      expect(current_path).to eq '/users'
    end
  end
end
