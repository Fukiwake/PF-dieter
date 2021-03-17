# frozen_string_literal: true

class DeviseCreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
      t.string :name, null: false
      t.integer :gender, null: false
      t.integer :birthyear, null: false
      t.date :birthdate, null: false
      t.float :height, null: false
      t.float :target_weight, null: false
      t.float :target_body_fat_percentage
      t.text :introduce
      t.string :profile_image_id
      t.boolean :is_deleted, default: false
      t.integer :total_exp, default: 0
      t.integer :month_exp, default: 0
      t.integer :week_exp, default: 0
      t.integer :day_exp, default: 0
      t.boolean :comment_notification, default: true
      t.boolean :favorite_notification, default: true
      t.boolean :chat_notification, default: true
      t.boolean :follow_notification, default: true
    end

    add_index :customers, :email,                unique: true
    add_index :customers, :reset_password_token, unique: true
    add_index :customers, :name
    add_index :customers, :introduce
    add_index :customers, :birthyear
    add_index :customers, :target_weight
    add_index :customers, :target_body_fat_percentage
    
    # add_index :customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
