class CreateAttendings < ActiveRecord::Migration[7.0]
  def change
    create_table :attendings do |t|

      t.timestamps
    end
  end
end
