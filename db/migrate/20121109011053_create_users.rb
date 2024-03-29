class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username,           :null => false, :default => ""
      t.string :fullname,           :default => ""
      t.string :email,              :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token
      
      #extra fields
      t.integer :agent_group_id, :default => 0
      t.integer :branch_id, :default => 0
      t.integer :category_id, :default => 0
      t.text    :address,           :default => ""
      t.string  :phone,           :default => ""
      t.string  :fax,           :default => ""
      t.text    :remark,           :default => ""
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :users, :username,             :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :category_id
    add_index :users, :agent_group_id
    add_index :users, :branch_id
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end
