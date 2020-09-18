class Address < ApplicationRecord
  belongs_to :order

  # active_hashの読み込み
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
