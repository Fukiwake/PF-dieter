# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject{ customer.valid? }
  let!(:customer) { build(:customer) }

  describe '実際に保存してみる' do
    it '有効な投稿内容は保存されるか' do
      is_expected.to eq true
    end
  end

  context 'バリデーションのテスト' do
    it 'nameカラムが空欄でないこと' do
      customer.name = ''
      is_expected.to eq false
      expect(customer.errors[:name]).to include("を入力してください")
    end
    it 'nameカラムが10文字以内であること' do
      customer.name = Faker::Lorem.characters(number:11)
      is_expected.to eq false
      expect(customer.errors[:name]).to include("は10文字以内で入力してください")
    end
    it 'genderカラムが空欄でないこと' do
      customer.gender = ''
      is_expected.to eq false
      expect(customer.errors[:gender]).to include("を入力してください")
    end
    it 'heightカラムが空欄でないこと' do
      customer.height = ''
      is_expected.to eq false
      expect(customer.errors[:height]).to include("を入力してください")
    end
    it 'heightカラムが数字であること' do
      customer.height = 'テスト'
      is_expected.to eq false
      expect(customer.errors[:height]).to include("は数値で入力してください")
    end
    it 'target_weightカラムが空欄でないこと' do
      customer.target_weight = ''
      is_expected.to eq false
      expect(customer.errors[:target_weight]).to include("を入力してください")
    end
    it 'target_weightカラムが数字であること' do
      customer.target_weight = 'テスト'
      is_expected.to eq false
      expect(customer.errors[:target_weight]).to include("は数値で入力してください")
    end
    it 'target_body_fat_percentageカラムが数字であること' do
      customer.target_body_fat_percentage = 'テスト'
      is_expected.to eq false
      expect(customer.errors[:target_body_fat_percentage]).to include("は数値で入力してください")
    end
    it 'ageカラムが数字であること' do
      customer.age = 'テスト'
      is_expected.to eq false
      expect(customer.errors[:age]).to include("は数値で入力してください")
    end
    it 'introduceカラムが200文字以内であること' do
      customer.introduce = Faker::Lorem.characters(number:201)
      is_expected.to eq false
      expect(customer.errors[:introduce]).to include("は200文字以内で入力してください")
    end
  end
end
