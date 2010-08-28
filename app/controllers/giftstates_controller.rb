class GiftstatesController < ApplicationController
  # GET /giftstates
  # GET /giftstates.xml
  def index
    @giftstates = Giftstate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @giftstates }
    end
  end

  # GET /giftstates/1
  # GET /giftstates/1.xml
  def show
    @giftstate = Giftstate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @giftstate }
    end
  end

  # GET /giftstates/new
  # GET /giftstates/new.xml
  def new
    @giftstate = Giftstate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @giftstate }
    end
  end

  # GET /giftstates/1/edit
  def edit
    @giftstate = Giftstate.find(params[:id])
  end

  # POST /giftstates
  # POST /giftstates.xml
  def create
    @giftstate = Giftstate.new(params[:giftstate])

    respond_to do |format|
      if @giftstate.save
        flash[:notice] = 'Giftstate was successfully created.'
        format.html { redirect_to(@giftstate) }
        format.xml  { render :xml => @giftstate, :status => :created, :location => @giftstate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @giftstate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /giftstates/1
  # PUT /giftstates/1.xml
  def update
    @giftstate = Giftstate.find(params[:id])

    respond_to do |format|
      if @giftstate.update_attributes(params[:giftstate])
        flash[:notice] = 'Giftstate was successfully updated.'
        format.html { redirect_to(@giftstate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @giftstate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /giftstates/1
  # DELETE /giftstates/1.xml
  def destroy
    @giftstate = Giftstate.find(params[:id])
    @giftstate.destroy

    respond_to do |format|
      format.html { redirect_to(giftstates_url) }
      format.xml  { head :ok }
    end
  end
end
