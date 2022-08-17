class CreateLogEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :log_entries do |t|
      t.string :uuid
      t.text :content
      t.string :content_type
      t.text :headers
      t.belongs_to :namespace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
