require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @address_form = FactoryBot.build(:address_form, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@address_form).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @address_form.user_id = 1
        expect(@address_form).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @address_form.item_id = 1
        expect(@address_form).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @address_form.zip_code = '123-4560'
        expect(@address_form).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @address_form.prefecture_id = 1
        expect(@address_form).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @address_form.city = '横浜市'
        expect(@address_form).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @address_form.block_number = '旭区１２３'
        expect(@address_form).to be_valid
      end
      it '建物名が空でも保存できる' do
        @address_form.apartment_name = nil
        expect(@address_form).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @address_form.phone_number = 12_345_678_910
        expect(@address_form).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @address_form.user_id = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("ユーザー情報を入力してください")
      end
      it 'item_idが空だと保存できない' do
        @address_form.item_id = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("商品情報を入力してください")
      end
      it '郵便番号が空だと保存できないこと' do
        @address_form.zip_code = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @address_form.zip_code = 1_234_567
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('郵便番号はハイフンを含めた半角文字列で入力してください (例：123-4567)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @address_form.prefecture_id = 0
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("都道府県を選択してください")
      end
      it '都道府県が空だと保存できないこと' do
        @address_form.prefecture_id = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空だと保存できないこと' do
        @address_form.city = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できないこと' do
        @address_form.block_number = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと保存できないこと' do
        @address_form.phone_number = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @address_form.phone_number = '123 - 1234 - 1234'
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @address_form.phone_number = 12_345_678_910_123_111
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
      it '電話番号が9桁以下では保存できない' do
        @address_form.phone_number = 123_456
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数値で入力してください')
      end
      it 'トークンが空だと保存できないこと' do
        @address_form.token = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end