class CreateNamespaces < ActiveRecord::Migration[7.0]
  def change
    create_table :namespaces do |t|
      t.string :name
      t.text :options
      t.string :uuid

      t.timestamps
    end
  end
end
