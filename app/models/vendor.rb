class Vendor < ActiveRecord::Base
  #has_and_belongs_to_many :posts
  has_many :line_items
  has_many :posts
  #belongs_to :posts
end
