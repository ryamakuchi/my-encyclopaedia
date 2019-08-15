require "rails_helper"

describe "POST devise/sessions#create", type: :system do
  let!(:email) { Faker::Internet.free_email }
  let!(:pw) { Faker::Internet.password(min_length: 6) }

  context "ログイン情報が正しい場合" do
    before do
      user_sign_up(mail_address: email, password: pw)
    end

    scenario "ログインが成功する" do
      user_sign_in(mail_address: email, password: pw)

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
      user_sign_in(mail_address: email, password: pw)

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
      user_sign_in(mail_address: '', password: '')

      expect(page).to have_content "Eメールまたはパスワードが違います。"
      expect(current_path).to eq user_session_path
      expect(page).to have_http_status :ok
    end
  end
end

describe "DELETE devise/sessions#destroy", type: :system do
  let!(:email) { Faker::Internet.free_email }
  let!(:pw) { Faker::Internet.password(min_length: 6) }

  context "ログインしている場合" do
    before do
      user_sign_up(mail_address: email, password: pw)
      user_sign_in(mail_address: email, password: pw)
    end

    scenario "ログアウトができる" do
      visit root_path
      click_on "ログアウト"

      expect(page).to have_content "ログアウトしました。"
      expect(current_path).to eq root_path
      expect(page).to have_http_status :ok
    end
  end
end
