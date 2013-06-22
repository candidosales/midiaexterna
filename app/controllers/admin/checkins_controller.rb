class Admin::CheckinsController < Admin::BaseController

  def index
    @checkins = Checkin.all
    respond_with @checkins
  end

  def new
    @checkin = Checkin.new({:reserva_id => params[:reserva_id]})
    2.times { @checkin.foto_checkins.build }
    respond_with @checkin
  end

  def create
    @checkin = Checkin.new(params[:checkin])
    @reserva = Reserva.find(params[:reserva_id])
    flash[:notice] = 'Checkin foi criado com sucesso.' if @checkin.save
    respond_with @reserva, :location => admin_reserva_path(@reserva)
  end

  def edit
    @checkin = Checkin.includes(:reserva).find(params[:id])
    (2 - @checkin.foto_checkins.length).times { @checkin.foto_checkins.build }
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy
    respond_with @checkin, :location => admin_checkins_path
  end
end