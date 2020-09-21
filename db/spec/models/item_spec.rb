require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('app/assets/images/sample.jpg')
    end

    describe '商品出品機能' do
      context '商品が出品できる時' do
        it '画像や値が全て存在し、プルダウンが全て選択されていれば保存できる' do
          expect(@item).to be_valid
        end
      end
      context '商品が出品できない時' do
        it 'imageが存在しない時は保存できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('画像を入力してください')
        end
        it 'item_nameが存在しない時は保存できない' do
          @item.item_name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('商品名を入力してください')
        end
        it 'textが存在しない時は保存できない' do
          @item.text = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の説明を入力してください')
        end
        it 'categoryが選択されていない時は保存できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('カテゴリーを選択して下さい')
        end
        it 'product_statusが選択されていない時は保存できない' do
          @item.product_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の状態を選択して下さい')
        end
        it 'shipping_fee_statusが選択されていない時は保存できない' do
          @item.shipping_fee_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('配送料の負担を選択して下さい')
        end
        it 'prefectureが選択されていない時は保存できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送元の地域を選択して下さい')
        end
        it 'scheduled_deliveryが選択されていない時は保存できない' do
          @item.scheduled_delivery_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送までの日数を選択して下さい')
        end
        it 'priceが存在しない時は保存できない' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('価格を入力してください', '価格は半角数字で入力して下さい', '価格の入力情報が正しくありません')
        end
        it 'priceが半角数字でなければ保存できない' do
          @item.price = '１０００'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は半角数字で入力して下さい')
        end
        it 'priceが300より小さいと保存できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
        end
        it 'priceが9999999より大きいと保存できない' do
          @item.price = 19_999_999
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
        end
      end
    end
  end
end
