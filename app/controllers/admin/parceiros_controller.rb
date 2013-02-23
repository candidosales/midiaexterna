class Admin::ParceirosController < Admin::BaseController
  # GET /parceiros
  # GET /parceiros.json
  def index
    @parceiros = Parceiro.all
    respond_with @parceiros
  end

  # GET /parceiros/1
  # GET /parceiros/1.json
  def show
    @parceiro = Parceiro.find(params[:id])
    respond_with @parceiros
  end

  # GET /parceiros/new
  # GET /parceiros/new.json
  def new
    @parceiro = Parceiro.new
    respond_with @parceiros
  end

  # GET /parceiros/1/edit
  def edit
    @parceiro = Parceiro.find(params[:id])
  end

  # POST /parceiros
  # POST /parceiros.json
  def create
    @parceiro = Parceiro.new(params[:parceiro])
    flash[:notice] = 'Parceiro foi criado com sucesso.' if @parceiro.save
    respond_with @parceiro, :location => admin_parceiros_path
  end

  # PUT /parceiros/1
  # PUT /parceiros/1.json
  def update
    @parceiro = Parceiro.find(params[:id])
    flash[:notice] = 'Parceiro foi atualizado com sucesso.' if @parceiro.update_attributes(params[:parceiro])
    respond_with @parceiro, :location => edit_admin_parceiro_path(@parceiro)
  end

  # DELETE /parceiros/1
  # DELETE /parceiros/1.json
  def destroy
    @parceiro = Parceiro.find(params[:id])
    @parceiro.destroy
    respond_with @parceiro, :location => admin_parceiros_path
  end
end
