class CreateCheckpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :checkpoints do |t|
      t.string :need
      t.string :neighborhood
      t.text :description
    end
  end
end
