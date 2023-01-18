class AddressForm
  include ActiveModel::Model

  # 配送先と購入記録の２つのモデルの全てのカラムを扱えるようにする
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :block_number, :apartment_name, :phone_number, :token

  with_options presence: true do
    # purchaseモデルのバリデーション
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンを含めた半角文字列で入力してください (例：123-4567)"}
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :block_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }
    # addressモデルのバリデーション
    validates :user_id
    validates :item_id
    # トークンのバリデーション
    validates :token
  end

  # データをそれぞれのテーブルに保存する処理
  def save
    # 購入情報を保存し、purchaseに代入する
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # purchase_idには、変数purchaseのidと指定する
    Address.create(purchase: purchase, zip_code: zip_code, prefecture_id: prefecture_id, city: city, block_number: block_number, apartment_name: apartment_name, phone_number: phone_number)
  end
end