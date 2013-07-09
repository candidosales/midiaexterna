class Admin::ClientesController < Admin::BaseController
  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
    respond_with @clientes
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "ok",
          :margin => {
                  :top => 45,
                  :bottom => 20
               },
          :header => {
                :spacing => 5,
                          :html => {
                             :template => 'shared/pdf/header.html'
                          }
                       },
          :footer => {
                          :html => {
                             :template => 'shared/pdf/footer.html'
                          }
                       }            
      end
    end
  end

  # GET /clientes/new
  # GET /clientes/new.json
  def new
    @cliente = Cliente.new
    respond_with @cliente
  end

  # GET /clientes/1/edit
  def edit
    @cliente = Cliente.find(params[:id])
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    flash[:notice] = 'Cliente foi criado com sucesso.' if @cliente.save
    respond_with @cliente, :location => admin_clientes_path
  end

  # PUT /clientes/1
  # PUT /clientes/1.json
  def update
    @cliente = Cliente.find(params[:id])
    flash[:notice] = 'Cliente foi atualizado com sucesso.' if @cliente.update_attributes(cliente_params)
    respond_with @cliente, :location => edit_admin_cliente_path(@cliente)
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy
    respond_with @cliente, :location => admin_clientes_path
  end

  private
    def cliente_params
      params.require(:cliente).permit!
    end

end
