class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :username
      t.string :encrypted_password
      t.string :tokens, array: true, default: []
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
