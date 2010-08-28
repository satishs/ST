class Cart
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_post(post)
    @items << post
  end
  
end
