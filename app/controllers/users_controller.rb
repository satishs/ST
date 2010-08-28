class UsersController < ApplicationController
  # GET /users/new
  # GET /users/new.xml

  layout "application"

  before_filter :load_user_using_perishable_token, :only => [:activate]

  #test code: delete it

  def index
    if current_user && current_user.admin?
      @users = User.find(:all)
    else
      redirect_to root_url
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    @user = current_user
    redirect_to :controller => :members, :action => :show
    return
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  
  # GET /users/1/edit
  def edit
    @user = current_user
  end

    # POST /user
  # POST /user.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        #if User.all.size < 2
        #  @user.add_role("admin")        
        #end
        
        flash[:notice] = 'Registration successful.'
        format.html { redirect_to(root_path) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash[:error] = 'Please fill the required data.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Successfully updated profile."
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

 def activate
    flash[:notice] = "Thanks for confirming your acocunt."
    @user.activate #set the activated at
    #login him in
    redirect_to login_url #redirect him to dash board
  end

private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account." +
        "If you are having issues try copying and pasting the URL " +
        "from your email into your browser or restarting the " +
        "reset password process."
      redirect_to root_url
    end

    #if @user.activated?
    #  flash[:notice] = "You have already activated your account."
    #  redirect_to root_url
    #end
 end
end