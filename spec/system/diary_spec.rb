# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト：日記' do
  let(:customer) { create(:customer) }
  let!(:diary) { create(:diary, customer_id: customer.id) }
  let!(:diet_method) { create(:diet_method, customer_id: customer.id) }
  let!(:check_list) { create(:check_list, diet_method_id: diet_method.id) }
  before do
    99.times do |n|
      LevelSetting.create(
        level: n + 1,
        threshold: 10 + n * 10
      )
    end
    Try.create(diet_method_id: diet_method.id, customer_id: customer.id)
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe '日記一覧ページのテスト' do
    it 'ヘッダーの日記を押すと、日記一覧画面に遷移する' do
      click_link '日記'
      expect(current_path).to eq '/diaries'
    end
    context '任意の日記タイトルを押下したとき' do
      before do
        click_link '日記'
        click_link diary.title
      end
      it '該当日記の詳細画面に遷移する' do
        expect(current_path).to eq '/diaries/' + diary.id.to_s
      end
    end
    context '任意の会員名を押下したとき' do
      before do
        click_link '日記'
        click_link customer.name
      end
      it '該当会員の詳細画面に遷移する' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end
    context '編集を押下したとき' do
      before do
        click_link '日記'
        click_link "編集"
      end
      it '該当日記の詳細画面に遷移する' do
        expect(current_path).to eq '/diaries/' + diary.id.to_s + '/edit'
      end
    end
    context '削除を押下したとき' do
      before do
        click_link '日記'
        click_link "削除する"
      end
      it '該当日記が削除される' do
        expect(Diary.where(id: diary.id).count).to eq 0
      end
    end
    context 'いいねボタンを押下したとき' do
      before do
        click_link '日記'
        click_link 'いいね'
      end
      it '該当日記がいいねされる' do
        expect(DiaryFavorite.where(diary_id: diary.id, customer_id: customer.id).count).to eq 1
      end
    end
  end

  describe '日記詳細ページのテスト' do
    before do
      click_link '日記'
      click_link diary.title
    end
    context '会員名を押下したとき' do
      before do
        click_link customer.name
      end
      it '該当会員の詳細画面に遷移する' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end
    context '編集を押下したとき' do
      before do
        click_link "編集"
      end
      it '該当日記の詳細画面に遷移する' do
        expect(current_path).to eq '/diaries/' + diary.id.to_s + '/edit'
      end
    end
    context '削除を押下したとき' do
      before do
        click_link "削除する"
      end
      it '該当日記が削除される' do
        expect(Diary.where(id: diary.id).count).to eq 0
      end
    end
    context 'いいねボタンを押下したとき' do
      before do
        click_link 'いいね'
      end
      it '該当日記がいいねされる' do
        expect(DiaryFavorite.where(diary_id: diary.id, customer_id: customer.id).present?).to eq true
      end
    end
    context 'コメントを入力し、送信したとき' do
      before do
        fill_in 'diary_comment[body]', with: 'コメントテスト'
        click_button '送信'
      end
      it '該当コメントが投稿され、表示される' do
        expect(DiaryComment.where(diary_id: diary.id, customer_id: customer.id, body: 'コメントテスト').present?).to eq true
        expect(page).to have_content 'コメントテスト'
      end
    end
  end

  describe '日記作成ページのテスト' do
    before do
      click_link '日記'
      click_link '日記を投稿'
      fill_in 'diary[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'diary[body]', with: Faker::Lorem.characters(number: 100)
      fill_in 'diary[weight]', with: rand(30..80)
      fill_in 'diary[body_fat_percentage]', with: rand(10..25)
      check "diary[check_list_diaries_attributes][0][check_list_id]"
      click_button '投稿する'
    end
    context '情報を入力して投稿したとき' do
      it '日記一覧画面に遷移する' do
        expect(current_path).to eq '/diaries'
      end
      it '日記が投稿される' do
        expect(Diary.where(customer_id: customer.id).count).to eq 2
      end
      it '日記とチェックリストの中間テーブルのデータが作成される' do
        expect(CheckListDiary.where(check_list_id: check_list.id).present?).to eq true
      end
    end
  end

  describe 'クイック投稿のテスト' do
    before do
      click_link '日記'
      fill_in 'diary[weight]', with: rand(30..80)
      fill_in 'diary[body_fat_percentage]', with: rand(10..25)
      check "diary[check_list_diaries_attributes][0][check_list_id]"
      click_button '投稿'
    end
    context '情報を入力して投稿したとき' do
      it '日記一覧画面に遷移する' do
        using_wait_time 5 do
          expect(current_path).to eq '/diaries'
        end
      end
      it '日記が投稿される' do
        expect(Diary.where(customer_id: customer.id).count).to eq 2
      end
      it '日記とチェックリストの中間テーブルのデータが作成される' do
        expect(CheckListDiary.where(check_list_id: check_list.id).present?).to eq true
      end
    end
  end

  describe '日記編集ページのテスト' do
    before do
      click_link '日記'
      click_link "編集"
      fill_in 'diary[title]', with: '編集テスト'
      click_button '編集する'
    end
    context '情報を入力して投稿したとき' do
      it '該当日記の詳細画面に遷移する' do
        expect(current_path).to eq '/diaries/' + diary.id.to_s
      end
      it '日記が編集される' do
        expect(page).to have_content '編集テスト'
      end
    end
  end
end