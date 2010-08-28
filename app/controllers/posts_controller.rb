class PostsController < ApplicationController

layout 'application'
#uses_yui_editor
before_filter :login_required, :except => ['index', 'show', 'search', 'sponser', 'add_to_cart', 'empty_cart']
@@per_page_count = 5

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all
    @posts = @posts.paginate :page => params[:page], :per_page => @@per_page_count, :order => 'updated_at DESC'
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def capture_orderno
    @post = Post.find(params[:id])
  end
  
  def sponsored
    @cart = find_cart
    for post in @cart.items
        #@post = Post.find(params[:id])
        post.giftstate_id = 3 #shipped
        #@post.vendor_id = params[:vendor]
        #@post.orderno = params[:orderno]
        post.save #TODO: put if condition
    end    
    #flash[:notice] = "Thank you very much for the sponsoring the gift"
    #empty_cart
    session[:cart] = nil
  end
  
  def sponsor_gift
    #TODO :check for gift's availability
    @post = Post.find(params[:id])
      
 #      if @post.giftstate_id.nil? || @post.giftstate_id == 1
        @post.user_id = current_user
        @post.giftstate_id = 2
        if @post.save
          @line_item = LineItem.find(params[:line_item_id])
          redirect_to @line_item.url
        else
          redirect_to posts_path
        end
#    else
#      flash[:notice] = 'We are sorry for the inconvience. Gift selected is not available. Please select some other gift.'
 #     redirect_to posts_path
#    end
    #@line_item = LineItem.find(params[:line_item_id])
  end
  
  def add_to_cart
    @cart = find_cart
    unless params[:post_id].nil?
      @post = Post.find(params[:post_id])
      #@line_item = @post.line_items.find{|item| item.id == params[:line_item_id]}
      @line_item = LineItem.find(params[:line_item_id])
      #check if post is already added to the cart.
      #if yes than display a flash notice and don't add that post and redirect to post index
      if @cart.items.include?(@post)
        flash[:notice] = 'Selected gift is already added to your cart'
        redirect_to posts_path and return
      end
      @cart.add_post(@post)
    end
  end
  
  def remove_cart_item
    @cart = find_cart
    unless params[:id].nil?
      @post = Post.find(params[:id])
      if @cart.items.include?(@post)
        @cart.items.delete(@post)
      end
    end
    render 'add_to_cart'
  end
  
  def capture_payment_details
    #@post = Post.find(params[:id])
    @cart = find_cart
    if @cart.items.empty?
      flash[:notice] = 'Your cart is empty. Please select a gift to sponsor'
      redirect_to posts_path
    end
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to posts_path
  end
  
  def search 
      set_page_index   
      if params[:search].empty?
        @posts = Post.all
        @total_posts_count = @posts.size
        @posts = @posts.paginate :page => params[:page], :per_page => @@per_page_count, :order => 'updated_at DESC'
      else
        @posts_product_name = Post.product_name_like_any(params[:search].to_s.split).ascend_by_product_name
        @posts_description = Post.description_like_all(params[:search].to_s.split).ascend_by_description
        #@posts_user = Question.user_fullname_like(params[:search].to_s.split)
        #@posts_tag = Question.find_tagged_with(params[:search])
        #@posts = (@posts_title+@posts_body+@posts_tag+@posts_user).uniq
        @posts = (@posts_product_name+@posts_description).uniq

        @total_posts_count = @posts.size
        @posts = @posts.paginate :page => params[:page], :per_page => @@per_page_count, :order => 'updated_at DESC'
      end
      render :action => "index"
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.organization_id = params[:organization]
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(posts_path) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @post.organization_id = params[:organization]
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(posts_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end


private
  def set_page_index
     @page_index = params[:page]
     if @page_index.to_i > 1
        @count = (@page_index.to_i-1)*5+1
     else 
        @count = 1    
     end
  end
  
  def find_cart
    session[:cart] ||= Cart.new
  end