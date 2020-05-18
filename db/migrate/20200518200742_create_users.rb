class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      t.timestamps
      t.string :name
      t.string :email
      t.string :address
    end
  end
end
