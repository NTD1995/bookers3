class CreateReadingLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :reading_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :read_on
      t.text :note

      t.timestamps
    end
  end
end
