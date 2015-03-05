class PlatformsController < ApplicationController

  def view
    @banner_for_platform = BannerForPlatform.includes(:banner).where(:platform_id => params[:id], :default => false)    
      .where('amount_views = (SELECT MIN(amount_views) from banner_for_platforms WHERE platform_id = ? AND "default" = ? AND amount_views < max_views)', 2, false)
      .where('amount_views < max_views').first
    @banner_for_platform = BannerForPlatform.where(:default => true, :platform_id => params[:id]).first if @banner_for_platform.blank?
    @banner_for_platform.amount_views += 1
    @banner_for_platform.save
  end
  # GET /platforms
  # GET /platforms.json
  def index
    @platforms = Platform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @platforms }
    end
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
    @platform = Platform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/new
  # GET /platforms/new.json
  def new
    @platform = Platform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @platform }
    end
  end

  # GET /platforms/1/edit
  def edit
    @platform = Platform.find(params[:id])
  end

  # POST /platforms
  # POST /platforms.json
  def create
    banners = Banner.where(:id => params[:platform].delete(:banners))
    @platform = Platform.new(params[:platform])
    @platform.banners = banners

    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
        format.json { render json: @platform, status: :created, location: @platform }
      else
        format.html { render action: "new" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /platforms/1
  # PUT /platforms/1.json
  def update
    @platform = Platform.find(params[:id])
    banners = Banner.where(:id => params[:platform].delete(:banners))
    @platform.banners = banners

    respond_to do |format|
      if @platform.update_attributes(params[:platform])
        format.html { redirect_to @platform, notice: 'Platform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platforms/1
  # DELETE /platforms/1.json
  def destroy
    @platform = Platform.find(params[:id])
    @platform.destroy

    respond_to do |format|
      format.html { redirect_to platforms_url }
      format.json { head :no_content }
    end
  end
end
