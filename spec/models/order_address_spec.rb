require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @order = FactoryBot.build(:order_address)
    end
    describe '商品購入機能' do
      context '購入機能がうまくいく時' do
        it '全ての値が正しく入力されていると購入できる' do
          expect(@order).to be_valid
        end
        it '建物名が入力されていなくても購入できる' do
          @order.building_name = nil
          expect(@order).to be_valid
        end
      end
      context '購入機能がうまくいかない時' do
        it 'カード情報が存在しない/もしくは正しくないとトークンが生成されず購入できない' do
          @order.token = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('クレジットカード情報を入力してください')
        end
        it '郵便番号が存在しないと購入できない' do
          @order.postal_code = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('郵便番号を入力してください', '郵便番号の入力情報が正しくありません')
        end
        it '郵便番号が正しい書き方でないと購入できない' do
          @order.postal_code = '1234567'
          @order.valid?
          expect(@order.errors.full_messages).to include('郵便番号の入力情報が正しくありません')
        end
        it '都道府県が選択されていないと購入できない' do
          @order.prefecture_id = 1
          @order.valid?
          expect(@order.errors.full_messages).to include('都道府県を選択して下さい')
        end
        it '市町村が存在しないと購入できない' do
          @order.city = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('市区町村を入力してください')
        end
        it '番地が存在しないと購入できない' do
          @order.house_number = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('番地を入力してください')
        end
        it '電話番号が存在しないと購入できない' do
          @order.telephone = nil
          @order.valid?
          expect(@order.errors.full_messages).to include('電話番号を入力してください', '電話番号の入力情報が正しくありません')
        end
        it '電話番号が正しい書き方でないと購入できない' do
          @order.telephone = 'ああ'
          @order.valid?
          expect(@order.errors.full_messages).to include('電話番号の入力情報が正しくありません')
        end
        it '電話番号が11文字より大きいと購入できない' do
          @order.telephone = '111111111111'
          @order.valid?
          expect(@order.errors.full_messages).to include('電話番号は11文字以内で入力してください')
        end
      end
    end
  end
end
