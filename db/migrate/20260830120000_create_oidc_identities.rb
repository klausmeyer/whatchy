class CreateOidcIdentities < ActiveRecord::Migration[8.1]
  def change
    create_table :oidc_identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :issuer, null: false
      t.string :uid, null: false
      t.string :email
      t.string :name
      t.string :picture
      t.jsonb :claims, null: false, default: {}

      t.timestamps
    end

    add_index :oidc_identities, [ :provider, :issuer, :uid ], unique: true
    add_index :oidc_identities, [ :user_id, :provider, :issuer ], unique: true
  end
end
