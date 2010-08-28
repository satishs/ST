class CreateGiftstates < ActiveRecord::Migration
  def self.up
    create_table :giftstates do |t|
      t.string :state
       
      #t.references :post
      t.timestamps
    end
  end

  def self.down
    drop_table :giftstates
  end
end
