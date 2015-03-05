class BannerForPlatformsController < ApplicationController
  def click
    @bfp = BannerForPlatform.find(params[:id])
    @bfp.amount_clicks += 1
    @bfp.save
    render :nothing => true
  end

  # GET /banner_for_platforms
  # GET /banner_for_platforms.json
  def index
    @banner_for_platforms = BannerForPlatform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banner_for_platforms }
    end
  end

  # GET /banner_for_platforms/1
  # GET /banner_for_platforms/1.json
  def show
    @banner_for_platform = BannerForPlatform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banner_for_platform }
    end
  end

  # GET /banner_for_platforms/new
  # GET /banner_for_platforms/new.json
  def new
    @banner_for_platform = BannerForPlatform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banner_for_platform }
    end
  end

  # GET /banner_for_platforms/1/edit
  def edit
    @banner_for_platform = BannerForPlatform.find(params[:id])
  end

  # POST /banner_for_platforms
  # POST /banner_for_platforms.json
  def create
    @banner_for_platform = BannerForPlatform.new(params[:banner_for_platform])

    respond_to do |format|
      if @banner_for_platform.save
        format.html { redirect_to @banner_for_platform, notice: 'Banner for platform was successfully created.' }
        format.json { render json: @banner_for_platform, status: :created, location: @banner_for_platform }
      else
        format.html { render action: "new" }
        format.json { render json: @banner_for_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banner_for_platforms/1
  # PUT /banner_for_platforms/1.json
  def update
    @banner_for_platform = BannerForPlatform.find(params[:id])

    respond_to do |format|
      if @banner_for_platform.update_attributes(params[:banner_for_platform])
        format.html { redirect_to @banner_for_platform, notice: 'Banner for platform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner_for_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banner_for_platforms/1
  # DELETE /banner_for_platforms/1.json
  def destroy
    @banner_for_platform = BannerForPlatform.find(params[:id])
    @banner_for_platform.destroy

    respond_to do |format|
      format.html { redirect_to banner_for_platforms_url }
      format.json { head :no_content }
    end
  end
end
