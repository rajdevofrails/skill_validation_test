class CreateChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :checks do |t|
      t.references :company, null: false, foreign_key: true
      t.string :image
      t.integer :number
      t.string :status

      t.timestamps
    end
  end
end
