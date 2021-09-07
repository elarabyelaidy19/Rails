class CreateKitties < ActiveRecord::Migration[6.1]
  def change
    create_table :kitties do |t|
      t.date :birth_date,  null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, null: false, limit: 1
      t.text :desicription

      t.timestamps
    end
  end
end
