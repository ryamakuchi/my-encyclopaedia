require "rails_helper"

describe "POST devise/sessions#create", type: :system do
  let!(:email) { Faker::Internet.free_email }
  let!(:pw) { Faker::Internet.password(min_length: 6) }

  context "ログイン情報が正しい場合" do
    before do
      user_sign_up(mail_address: email, password: pw)
    end

    scenario "ログインが成功する" do
      visit new_user_session_path
      expect(page).to have_http_status :ok

      fill_in "Eメール", with: email
      fill_in "パスワード", with: pw
      click_on "ログイン"

      expect(page).to have_content "ログインしました。"
      expect(current_path).to eq root_path
      expect(page).to have_http_status :ok
    end
  end

  context "ログイン情報が正しいがメール認証がまだの場合" do
    before do
      user_sign_up(mail_address: email, password: pw, confirmation: false)
    end

    scenario "ログインが失敗する" do
      visit new_user_session_path

      fill_in "Eメール", with: email
      fill_in "パスワード", with: pw
      click_on "ログイン"

      expect(page).to have_content "メールアドレスの本人確認が必要です。"
      expect(current_path).to eq user_session_path
      expect(page).to have_http_status :ok
    end
  end

  context "ログイン情報が正しくない場合" do
    before do
      user_sign_up(mail_address: email, password: pw)
    end

    scenario "ログインが失敗する" do
      visit new_user_session_path

      fill_in "Eメール", with: ''
      fill_in "パスワード", with: ''
      click_on "ログイン"

      expect(page).to have_content "Eメールまたはパスワードが違います。"
      expect(current_path).to eq user_session_path
      expect(page).to have_http_status :ok
    end
  end
end
