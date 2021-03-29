# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン後のテスト：会員' do
  let!(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer, name: "test") }

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

  describe '会員一覧ページのテスト' do
    it 'ヘッダーのユーザーを押すと、会員一覧画面に遷移する' do
      click_link 'ユーザー'
      expect(current_path).to eq '/customers'
    end
    context '任意の会員名を押下したとき' do
      before do
        click_link 'ユーザー'
        click_link other_customer.name
      end

      it '該当会員の詳細画面に遷移する' do
        expect(current_path).to eq '/customers/' + other_customer.id.to_s
      end
    end

    context 'フォローボタンを押下したとき' do
      before do
        click_link 'ユーザー'
        click_link "フォロー"
      end

      it '該当会員をフォローする' do
        expect(Relationship.where(follower_id: customer.id, followed_id: other_customer.id).present?).to eq true
      end
    end
  end

  describe '会員詳細ページのテスト' do
    before do
      click_link 'ユーザー'
      click_link other_customer.name
    end

    context 'フォローボタンを押下したとき' do
      before do
        click_link "フォロー"
      end

      it '該当会員をフォローする' do
        expect(Relationship.where(follower_id: customer.id, followed_id: other_customer.id).present?).to eq true
      end
      context '通知するを押下したとき' do
        before do
          find('#notification').click
        end

        it 'Relationshipが更新される' do
          expect(Relationship.find_by(follower_id: customer.id, followed_id: other_customer.id).notification).to eq true
        end
      end
    end

    context 'ブロックを押下したとき' do
      before do
        click_link "ブロックする"
      end

      it '該当会員をブロックする' do
        expect(Block.find_by(blocker_id: customer.id, blocked_id: other_customer.id).present?).to eq true
      end
    end

    context '報告を押下したとき' do
      before do
        click_link "報告"
      end

      it '該当会員を報告する' do
        expect(Report.find_by(visitor_id: customer.id, visited_id: other_customer.id).present?).to eq true
      end
    end

    context 'チャットを押下したとき' do
      before do
        find('#chat-link').click
      end

      it 'チャット詳細画面に遷移する' do
        expect(current_path).to eq '/chat/' + other_customer.id.to_s
      end
    end
  end

  describe 'マイページのテスト' do
    before do
      click_link 'マイページ'
    end

    it 'ヘッダーのマイページを押すと、マイページに遷移する' do
      expect(current_path).to eq '/customers/' + customer.id.to_s
    end
    it 'プロフィールを編集を押すとプロフィール編集画面に遷移する' do
      click_link 'プロフィールを編集'
      expect(current_path).to eq '/setting'
    end
  end

  # describe 'チャットのテスト' do
  #   before do
  #     click_link 'ユーザー'
  #     click_link other_customer.name
  #     find('#chat-link').click
  #   end
  #   it 'チャットを送信する' do
  #     fill_in 'message-form', with: "test"
  #     find(".fa-angle-double-right").click
  #     using_wait_time 5 do
  #       expect(Chat.find_by(message: "test").present?).to eq true
  #     end
  #   end
  # end
end
