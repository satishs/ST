class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :product_name
      t.string :kids_tag
      t.integer :age
      t.text :description
      t.string :orderno

      t.references :user
      t.references :organization
      #t.references :sponser
      t.references :giftstate
      t.references :vendor
  
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
