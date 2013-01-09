class Admin::OutdoorsController < Admin::BaseController
  # GET /outdoors
  # GET /outdoors.json
  def index
    @outdoors = Outdoor.all
    respond_with @outdoors
  end

  # GET /outdoors/1
  # GET /outdoors/1.json
  def show
    @outdoor = Outdoor.find(params[:id])
    respond_with @outdoor
  end

  # GET /outdoors/new
  # GET /outdoors/new.json
  def new
    @outdoor = Outdoor.new
    5.times { @outdoor.foto_outdoors.build }
    respond_with @outdoor
  end

  # GET /outdoors/1/edit
  def edit
    @outdoor = Outdoor.find(params[:id])
    (5 - @outdoor.foto_outdoors.length).times { @outdoor.foto_outdoors.build }
  end

  # POST /outdoors
  # POST /outdoors.json
  def create
    @outdoor = Outdoor.new(params[:outdoor])
    flash[:notice] = 'Outdoor foi criado com sucesso.' if @outdoor.save
    respond_with @outdoor, :location => admin_outdoors_path
  end

  # PUT /outdoors/1
  # PUT /outdoors/1.json
  def update
    @outdoor = Outdoor.find(params[:id])
    flash[:notice] = 'Outdoor foi atualizado com sucesso.' if @outdoor.update_attributes(params[:outdoor])
    respond_with @outdoor, :location => edit_admin_outdoor_path(@outdoor)
  end

  # DELETE /outdoors/1
  # DELETE /outdoors/1.json
  def destroy
    @outdoor = Outdoor.find(params[:id])
    @outdoor.destroy
    respond_with @outdoor, :location => admin_outdoors_path
  end

  def destroy_multiple
    params[:delete].each do |id|
      Outdoor.find(id.to_i).destroy
    end
    respond_with @outdoor, :location => admin_outdoors_path
  end
  
end
