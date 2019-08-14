require "rails_helper"

RSpec.describe "POST devise/registrations#create", type: :system do
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

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to eq [mail_address]
  end

  describe 'バリデーションエラーの場合' do
    it '本人確認用のメールが送信されない'
    it 'アカウント登録ページが表示されている'

    context 'Eメールが入力されていない場合' do
      it '「Eメールを入力してください」という文言が表示される'
    end

    context 'パスワードが入力されていない場合' do
      it '「パスワードを入力してください」という文言が表示される'
    end

    context 'パスワードが6文字以上入力されていない場合' do
      it '「パスワードは6文字以上で入力してください」という文言が表示される'
    end

    context 'パスワード（確認用）が一致していない場合' do
      it '「パスワード（確認用）とパスワードの入力が一致しません」という文言が表示される'
    end
  end
end
