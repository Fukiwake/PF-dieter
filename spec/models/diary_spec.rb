# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, type: :model do
  subject{ diary.valid? }
  let(:customer) { create(:customer) }
  let!(:diary) { build(:diary, customer_id: customer.id) }

  describe '実際に保存してみる' do
    it '有効な投稿内容は保存されるか' do
      is_expected.to eq true
    end
  end

  context 'バリデーションのテスト' do
    it 'titleカラムが15文字以内であること' do
      diary.title = Faker::Lorem.characters(number:16)
      is_expected.to eq false
      expect(diary.errors[:title]).to include("は15文字以内で入力してください")
    end
    it 'weightカラムが空欄でないこと' do
      diary.weight = ''
      is_expected.to eq false
      expect(diary.errors[:weight]).to include("を入力してください")
    end
    it 'weightカラムが数字であること' do
      diary.weight = 'テスト'
      is_expected.to eq false
      expect(diary.errors[:weight]).to include("は数値で入力してください")
    end
    it 'body_fat_percentageカラムが数字であること' do
      diary.body_fat_percentage = 'テスト'
      is_expected.to eq false
      expect(diary.errors[:body_fat_percentage]).to include("は数値で入力してください")
    end
    it 'bodyカラムが200文字以内であること' do
      diary.body = Faker::Lorem.characters(number:201)
      is_expected.to eq false
      expect(diary.errors[:body]).to include("は200文字以内で入力してください")
    end
  end
end
