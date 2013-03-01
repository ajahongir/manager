class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.boolean :status, default: false
      t.integer :post_id
      t.timestamps
    end

    add_index :employees, [:post_id]
  end
end
