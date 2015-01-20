class CreateConfigStoreValues < ActiveRecord::Migration
  def change
    create_table :config_store_values, :force => true do |t|
      t.string :name
      t.string :value
      t.string :data_type

      t.timestamps
    end
  end
end