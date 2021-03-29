# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DietMethod, type: :model do
  subject { diet_method.valid? }

  let(:customer) { create(:customer) }
  let!(:diet_method) { build(:diet_method, customer_id: customer.id) }

  describe '実際に保存してみる' do
    it '有効な投稿内容は保存されるか' do
      is_expected.to eq true
    end
  end

  context 'バリデーションのテスト' do
    it 'titleカラムが15文字以内であること' do
      diet_method.title = Faker::Lorem.characters(number: 16)
      is_expected.to eq false
      expect(diet_method.errors[:title]).to include("は15文字以内で入力してください")
    end
    it 'wayカラムが空欄でないこと' do
      diet_method.way = ""
      is_expected.to eq false
      expect(diet_method.errors[:way]).to include("を入力してください")
    end
  end
end
