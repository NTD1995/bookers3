class CreateGroupMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :group_messages do |t|
      t.string :title
      t.text :body
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
