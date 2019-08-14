# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require "rails_helper"

describe User, type: :model do
  describe "POST devise/registrations#create" do
    let(:user) { create(:user) }
    it { expect(user).to be_valid }

    context "Eメールが入力されていないとき" do
      let(:user) { build(:user, email: nil) }

      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:email]).to include "を入力してください"
      end
    end

    context "Eメールが正しく入力されていないとき" do
      let(:user) { build(:user, email: 'ryamakuchi') }

      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:email]).to include "は不正な値です"
      end
    end

    context "パスワードが入力されていないとき" do
      let(:user) { build(:user, password: nil) }

      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include "を入力してください"
      end
    end

    context "パスワードが6文字以上入力されていないとき" do
      let(:user) { build(:user, password: 'a' * 5) }

      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include "は6文字以上で入力してください"
      end
    end

    context "保存されたメールアドレスが指定されたとき" do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, email: user1.email) }

      it "エラーになる" do
        user2.valid?
        expect(user2.errors.messages[:email]).to include "はすでに存在します"
      end
    end
  end
end
