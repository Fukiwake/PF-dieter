# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト：ダイエット方法' do
  let(:customer) { create(:customer) }
  let!(:diet_method) { create(:diet_method, customer_id: customer.id) }
  let!(:check_list) { create(:check_list, diet_method_id: diet_method.id) }

  before do
    99.times do |n|
      LevelSetting.create(
        level: n + 1,
        threshold: 10 + n * 10
      )
    end
    15.times do |n|
      Achievement.create(
        title: Faker::Lorem.characters(number: 5),
        description: Faker::Lorem.characters(number: 5),
        difficulty: rand(1..5),
        batch: Faker::Lorem.characters(number: 5)
      )
    end
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ダイエット方法一覧ページのテスト' do
    it 'ヘッダーのダイエット方法を押すと、ダイエット方法一覧画面に遷移する' do
      click_link 'ダイエット方法'
      expect(current_path).to eq '/diet_methods'
    end
    context '任意のダイエット方法タイトルを押下したとき' do
      before do
        click_link 'ダイエット方法'
        click_link diet_method.title
      end

      it '該当ダイエット方法の詳細画面に遷移する' do
        expect(current_path).to eq '/diet_methods/' + diet_method.id.to_s
      end
    end

    context '任意の会員名を押下したとき' do
      before do
        click_link 'ダイエット方法'
        click_link customer.name
      end

      it '該当会員の詳細画面に遷移する' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end

    context '編集を押下したとき' do
      before do
        click_link 'ダイエット方法'
        click_link "編集"
      end

      it '該当ダイエット方法の詳細画面に遷移する' do
        expect(current_path).to eq '/diet_methods/' + diet_method.id.to_s + '/edit'
      end
    end

    context '削除を押下したとき' do
      before do
        click_link 'ダイエット方法'
        click_link "削除する"
      end

      it '該当ダイエット方法が削除される' do
        expect(DietMethod.where(id: diet_method.id).count).to eq 0
      end
    end

    context 'いいねボタンを押下したとき' do
      before do
        click_link 'ダイエット方法'
        click_link 'いいね'
      end

      it '該当ダイエット方法がいいねされる' do
        expect(DietMethodFavorite.where(diet_method_id: diet_method.id, customer_id: customer.id).count).to eq 1
      end
    end
  end

  describe 'ダイエット方法詳細ページのテスト' do
    before do
      click_link 'ダイエット方法'
      click_link diet_method.title
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

      it '該当ダイエット方法の詳細画面に遷移する' do
        expect(current_path).to eq '/diet_methods/' + diet_method.id.to_s + '/edit'
      end
    end

    context '削除を押下したとき' do
      before do
        click_link "削除する"
      end

      it '該当ダイエット方法が削除される' do
        expect(DietMethod.where(id: diet_method.id).count).to eq 0
      end
    end

    context 'いいねボタンを押下したとき' do
      before do
        click_link 'いいね'
      end

      it '該当ダイエット方法がいいねされる' do
        expect(DietMethodFavorite.where(diet_method_id: diet_method.id, customer_id: customer.id).present?).to eq true
      end
    end

    context 'コメントを入力し、送信したとき' do
      before do
        fill_in 'diet_method_comment[body]', with: 'コメントテスト'
        click_button '送信'
      end

      it '該当コメントが投稿され、表示される' do
        expect(DietMethodComment.where(diet_method_id: diet_method.id, customer_id: customer.id, body: 'コメントテスト').present?).to eq true
        expect(page).to have_content 'コメントテスト'
      end
    end
  end

  describe 'ダイエット方法作成ページのテスト' do
    before do
      click_link 'ダイエット方法'
      click_link 'ダイエット方法を投稿'
      fill_in 'diet_method[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'diet_method[tag_list]', with: 'タグテスト'
      fill_in 'diet_method[way]', with: Faker::Lorem.characters(number: 100)
      fill_in 'diet_method[attention]', with: Faker::Lorem.characters(number: 100)
      fill_in 'diet_method[check_lists_attributes][0][body]', with: 'チェックリストテスト'
      click_button '投稿する'
    end

    context '情報を入力して投稿したとき' do
      it 'ダイエット方法一覧画面に遷移する' do
        expect(current_path).to eq '/diet_methods'
      end
      it 'ダイエット方法が投稿される' do
        expect(DietMethod.where(customer_id: customer.id).count).to eq 2
      end
      it 'タグが作成される' do
        expect(DietMethod.where(customer_id: customer.id).last.tag_counts_on(:tags).present?).to eq true
      end
      it 'チェックリストが作成される' do
        expect(CheckList.find_by(body: 'チェックリストテスト').present?).to eq true
      end
    end
  end

  describe 'ダイエット方法編集ページのテスト' do
    before do
      click_link 'ダイエット方法'
      click_link "編集"
      fill_in 'diet_method[title]', with: '編集テスト'
      click_button '編集する'
    end

    context '情報を入力して投稿したとき' do
      it '該当ダイエット方法の詳細画面に遷移する' do
        expect(current_path).to eq '/diet_methods/' + diet_method.id.to_s
      end
      it 'ダイエット方法が編集される' do
        expect(page).to have_content '編集テスト'
      end
    end
  end
end
