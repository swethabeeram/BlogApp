class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :title
      t.text :description
      t.string :business_type
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
