require 'rails_helper'

RSpec.describe 'POST devise/registrations#create', type: :system do
  context 'Eメールとパスワード（6字以上）とパスワード（確認用）が正しく入力されているとき' do
    it '本人確認用のメールが送信される'
    it 'トップページが表示されている'
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
