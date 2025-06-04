class CreateReadingStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :reading_statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
