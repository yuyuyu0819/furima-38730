require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  before do
    @order = FactoryBot.build(:address_form)
  end

  context '内容に問題ない場合' do
    it "priceがあれば保存ができること" do
      expect(@address_form).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "priceが空では保存ができないこと" do
      @order.price = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Price can't be blank")
    end
  end
end