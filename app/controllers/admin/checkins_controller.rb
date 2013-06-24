class Admin::CheckinsController < Admin::BaseController

  def index
    @checkins = Checkin.all
    respond_with @checkins
  end

  def show
    @checkin = Checkin.includes(:reserva).find(params[:id])
    respond_with @checkin
  end

  def new

    @checkin = Checkin.new({:reserva_id => params[:reserva_id]})

    @checkin.reserva.outdoors.length.times{@checkin.outdoor_checkins.build} 
    @checkin.outdoor_checkins.each{ |o| 2.times {o.foto_checkins.build }}
    
    respond_with @checkin
  end

  def create
    @checkin = Checkin.new(params[:checkin])
    flash[:notice] = 'Checkin foi criado com sucesso.' if @checkin.save
    respond_with @checkin.reserva, :location => admin_reserva_path(@checkin.reserva)
  end

  def update
    @checkin = Checkin.find(params[:id])
    flash[:notice] = 'Checkin foi atualizado com sucesso.' if @checkin.update_attributes(params[:checkin])
    respond_with @checkin, :location => edit_admin_reserva_checkin_path(@checkin.reserva, @checkin)
  end

  def edit
    @checkin = Checkin.includes(:reserva).find(params[:id])
    @checkin.outdoor_checkins.each{ |o|
      (2 - o.foto_checkins.length).times { o.foto_checkins.build }
    }
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy
    respond_with @checkin, :location => admin_checkins_path
  end

  
  def send_checkin_cliente(options={})
    @checkin = Checkin.find(params[:checkin])
    begin
      if(params.has_key?(:checkin))
        result = ClienteMailer.checkin_cliente(@checkin).deliver        
      end
    end
    flash[:notice] = "E-mail enviado para o #{@checkin.reserva.cliente.nome} com sucesso. =]" 
    redirect_to admin_reserva_path(@checkin.reserva)
  end
end