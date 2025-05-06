class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.reference :user, null: false, foreign_key: true
      t.reference :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
