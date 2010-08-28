class Post < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user   #TODO: change it to belongs_to a sponsor which of class user
  #belongs_to :sponser
  #has_and_belongs_to_many :vendors
  has_many :line_items
  belongs_to :giftstate
  belongs_to :vendor
  
  #validates_presence_of :orderno
end
