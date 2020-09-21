require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー登録機能' do
      context 'ユーザー登録機能がうまくいく時' do
        it '値が全て存在すれば登録できる' do
          expect(@user).to be_valid
        end
        it 'passwordが6文字以上の英数字なら登録できる' do
          @user.password = '111aaa'
          @user.password_confirmation = '111aaa'
          expect(@user).to be_valid
        end
        it '本名が全角かな/カナ漢字なら登録できる' do
          @user.first_name = '仮名'
          @user.last_name = '仮名'
          expect(@user).to be_valid
        end
        it '本名フリガナがカタカナなら登録できる' do
          @user.first_kana = 'カナ'
          @user.last_kana = 'カナ'
          expect(@user).to be_valid
        end
      end
      context 'ユーザー登録機能がうまくいかない時' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('ニックネームを入力してください')
        end
        it 'emailが空だと登録できない' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.invalid?
          expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
        end
        it 'passwordが空だと登録できない' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワードの入力情報が正しくありません',
                                                        'パスワードは6文字以上で入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
        end
        it 'passwordが5文字以下だと登録できない' do
          @user.password = '111aa'
          @user.password_confirmation = '111aa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
        end
        it 'passwordが英字のみだと登録できない' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードの入力情報が正しくありません')
        end
        it 'passwordが数字のみだと登録できない' do
          @user.password = '111111'
          @user.password_confirmation = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードの入力情報が正しくありません')
        end
        it 'passwordがあってもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
        end
        it '本名が空だと登録できない' do
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前(姓)を入力してください', 'お名前(姓)の入力情報が正しくありません')
        end
        it 'first_nameが英数字だと登録できない' do
          @user.first_name = 'aa'
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前(姓)の入力情報が正しくありません')
        end
        it 'last_nameが空だと登録できない' do
          @user.last_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前(名)を入力してください', 'お名前(名)の入力情報が正しくありません')
        end
        it 'last_nameが英数字だと登録できない' do
          @user.last_name = 'aa'
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前(名)の入力情報が正しくありません')
        end
        it 'first_kanaが空だと登録できない' do
          @user.first_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前カナ(姓)を入力してください', 'お名前カナ(姓)の入力情報が正しくありません')
        end
        it 'first_kanaが英数字か全角かな漢字だと登録できない' do
          @user.first_kana = '仮名'
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前カナ(姓)の入力情報が正しくありません')
        end
        it 'last_kanaが空だと登録できない' do
          @user.last_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前カナ(名)を入力してください', 'お名前カナ(名)の入力情報が正しくありません')
        end
        it 'last_kanaが英数字か全角かな漢字だと登録できない' do
          @user.last_kana = '仮名'
          @user.valid?
          expect(@user.errors.full_messages).to include('お名前カナ(名)の入力情報が正しくありません')
        end
      end
    end
  end
end
