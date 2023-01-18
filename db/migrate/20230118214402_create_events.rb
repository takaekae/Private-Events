class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.datetime :date
      t.boolean :private

      t.timestamps
    end
  end
end
