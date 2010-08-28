class LineItem < ActiveRecord::Base
  belongs_to :post
  belongs_to :vendor
end
