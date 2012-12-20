class OutdoorsController < ApplicationController
  # GET /outdoors
  # GET /outdoors.json
  def index
    @outdoors = Outdoor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outdoors }
    end
  end

  # GET /outdoors/1
  # GET /outdoors/1.json
  def show
    @outdoor = Outdoor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outdoor }
    end
  end

  # GET /outdoors/new
  # GET /outdoors/new.json
  def new
    @outdoor = Outdoor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outdoor }
    end
  end

  # GET /outdoors/1/edit
  def edit
    @outdoor = Outdoor.find(params[:id])
  end

  # POST /outdoors
  # POST /outdoors.json
  def create
    @outdoor = Outdoor.new(params[:outdoor])

    respond_to do |format|
      if @outdoor.save
        format.html { redirect_to @outdoor, notice: 'Outdoor was successfully created.' }
        format.json { render json: @outdoor, status: :created, location: @outdoor }
      else
        format.html { render action: "new" }
        format.json { render json: @outdoor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /outdoors/1
  # PUT /outdoors/1.json
  def update
    @outdoor = Outdoor.find(params[:id])

    respond_to do |format|
      if @outdoor.update_attributes(params[:outdoor])
        format.html { redirect_to @outdoor, notice: 'Outdoor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outdoor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outdoors/1
  # DELETE /outdoors/1.json
  def destroy
    @outdoor = Outdoor.find(params[:id])
    @outdoor.destroy

    respond_to do |format|
      format.html { redirect_to outdoors_url }
      format.json { head :no_content }
    end
  end
end
