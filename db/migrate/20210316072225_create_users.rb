class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :id_card
      t.date :birthday
      t.integer :deleted, default: 0
      t.integer :role, default: 0
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
