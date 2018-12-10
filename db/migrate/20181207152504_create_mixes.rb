class CreateMixes < ActiveRecord::Migration[5.0]
  def change
    create_table :mixes do |t|
      t.string :name
      t.string :file
      t.json :knobs

      t.timestamps
    end
  end
end
