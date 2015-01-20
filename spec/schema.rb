ActiveRecord::Schema.define do
  self.verbose = false

  create_table :config_store_values, :force => true do |t|
    t.string :name
    t.string :value
    t.string :data_type

    t.timestamps
  end

end