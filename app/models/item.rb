class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # テーブル とのアソシエーション
  belongs_to :user

  has_one :purchase
  has_one_attached :image

  # アクティブハッシュとのアソシエーション
  belongs_to :category
  belongs_to :prefecture
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :delivery_date

  # アクティブストレージとのアソシエーション
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :category_id, length: { minimum: 1 }
    validates :status_id, length: { minimum: 1 }
    validates :delivery_charge_id, length: { minimum: 1 }
    validates :prefecture_id, length: { minimum: 1 }
    validates :delivery_date_id, length: { minimum: 1 }
    # 300円以上かつ9,999,999円以下で、半角英数字でないと入力不可
    validates :price, inclusion: { in: 300..9_999_999 }, numericality: { only_integer: true }
  end

  # ジャンル選択が「ーー」の時は保存不可
  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :delivery_date_id
    validates :prefecture_id
  end
end