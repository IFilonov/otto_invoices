# 1. rails generate model batch_file guid:string:uniq batch_id:integer{7}:uniq
# 2. add 'null: false' for guid, batch_id
class CreateBatchFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :batch_files do |t|
      t.string :guid, null: false
      t.integer :batch_id, limit: 7, null: false

      t.timestamps
    end
    add_index :batch_files, :guid, unique: true
    add_index :batch_files, :batch_id, unique: true
  end
end
