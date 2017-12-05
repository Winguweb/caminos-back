class CreateUserAndProfile < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string    :username
      t.index     :username, unique: true
      t.string    :email
      t.index     :email, unique: true

      # Authlogic::ActsAsAuthentic::Password
      t.string    :crypted_password
      t.string    :password_salt

      # Authlogic::ActsAsAuthentic::PersistenceToken
      t.string    :persistence_token
      t.index     :persistence_token, unique: true

      # Authlogic::ActsAsAuthentic::SingleAccessToken
      t.string    :single_access_token
      t.index     :single_access_token, unique: true

      # Authlogic::ActsAsAuthentic::PerishableToken
      t.string    :perishable_token
      t.index     :perishable_token, unique: true

      # Authlogic::Session::MagicColumns
      t.integer   :login_count, default: 0, null: false
      t.integer   :failed_login_count, default: 0, null: false
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip

      # Authlogic::Session::MagicStates
      t.boolean   :active, default: false
      t.boolean   :approved, default: false
      t.boolean   :confirmed, default: false

      t.integer :roles_mask, index: true

      t.jsonb :settings, null: false, default: {}

      t.datetime :deleted_at

      t.timestamps
    end
    add_index  :users, :settings, using: :gin

    create_table :profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name

      t.uuid :user_id, null: false, index: true

      t.timestamps
    end
  end
end
