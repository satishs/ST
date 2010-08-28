class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.float :price
      t.string :url
      t.datetime :validity

      t.references :vendor
      t.references :post
      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
