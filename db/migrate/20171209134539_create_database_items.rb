class CreateDatabaseItems < ActiveRecord::Migration[5.1]
  def change
    create_table :database_items do |t|
      t.string :string
      t.integer :integer

      t.timestamps
    end
  end
end
