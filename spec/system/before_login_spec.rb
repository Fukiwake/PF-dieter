# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン前のテスト' do
  before do
    visit root_path
    15.times do |n|
      Achievement.create(
        title: Faker::Lorem.characters(number: 5),
        description: Faker::Lorem.characters(number: 5),
        difficulty: rand(1..5),
        batch: Faker::Lorem.characters(number: 5)
      )
    end
  end

  context 'ヘッダーの表示の確認' do
    it '日記を押すと、日記一覧画面に遷移する' do
      click_link '日記'
      expect(current_path).to eq '/diaries'
    end
    it 'ダイエット方法を押すと、ダイエット方法一覧画面に遷移する' do
      click_link 'ダイエット方法'
      expect(current_path).to eq '/diet_methods'
    end
    it 'ユーザーを押すと、ユーザー一覧画面に遷移する' do
      click_link 'ユーザー'
      expect(current_path).to eq '/customers'
    end
    it 'ランキングを押すと、ランキング画面に遷移する' do
      click_link 'ランキング'
      expect(current_path).to eq '/customers/ranking'
    end
  end

  context '新規登録のテスト' do
    it 'トップページで新規登録画面へのリンクを押下すると新規登録画面が表示される' do
      click_link '新規登録'
      expect(current_path).to eq '/customers/sign_up'
    end
    context '実際に新規登録する' do
      before do
        99.times do |n|
          LevelSetting.create(
            level: n + 1,
            threshold: 10 + n * 10
          )
        end
        visit new_customer_registration_path
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
        click_button 'プロフィール入力に進む'
        gimei = Gimei::Name.new
        fill_in 'customer[name]', with: gimei.first.katakana
        choose "customer_gender_male"
        fill_in 'customer[age]', with: rand(10..60)
        fill_in 'customer[height]', with: rand(130..200)
        fill_in 'customer[target_weight]', with: rand(30..80)
        fill_in 'customer[target_body_fat_percentage]', with: rand(10..25)
        click_button '新規登録'
      end

      it '新規登録後、日記一覧へ遷移する' do
        expect(current_path).to eq '/diaries'
      end
      context '新規登録後、ヘッダがログイン後の表示に変わっている' do
        it '「日記」と表示される' do
          expect(page).to have_link '日記'
        end
        it '「ダイエット方法」と表示される' do
          expect(page).to have_link 'ダイエット方法'
        end
        it '「マイページ」と表示される' do
          expect(page).to have_link 'マイページ'
        end
        it '「ユーザー」と表示される' do
          expect(page).to have_link 'ユーザー'
        end
        it '「ランキング」と表示される' do
          expect(page).to have_link 'ランキング'
        end
      end
    end
  end

  context 'ログインのテスト' do
    let(:customer) { create(:customer) }

    before do
      99.times do |n|
        LevelSetting.create(
          level: n + 1,
          threshold: 10 + n * 10
        )
      end
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    it 'ログイン後、メッセージが表示される' do
      expect(page).to have_content('ログインしました。')
    end
    it '新規登録後、日記一覧へ遷移する' do
      expect(current_path).to eq '/diaries'
    end
    context '新規登録後、ヘッダがログイン後の表示に変わっている' do
      it '「日記」と表示される' do
        expect(page).to have_link '日記'
      end
      it '「ダイエット方法」と表示される' do
        expect(page).to have_link 'ダイエット方法'
      end
      it '「マイページ」と表示される' do
        expect(page).to have_link 'マイページ'
      end
      it '「ユーザー」と表示される' do
        expect(page).to have_link 'ユーザー'
      end
      it '「ランキング」と表示される' do
        expect(page).to have_link 'ランキング'
      end
    end
  end
end
