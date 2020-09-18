class Item < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  has_one_attached :image

  # Active Hashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :product_status
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  # 空の投稿を保存できないようにする
  validates :image, :item_name, :text, presence: true
  # 価格の範囲を¥300~¥9,999,999の間に設定,また半角数字しか保存できないようにする
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }
  # ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :product_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1 }
end
