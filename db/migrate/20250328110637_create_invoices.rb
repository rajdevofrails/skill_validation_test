class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :company, null: false, foreign_key: true
      t.string :image
      t.string :category
      t.string :status

      t.timestamps
    end
  end
end
