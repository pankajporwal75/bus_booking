class BusesController < ApplicationController

  before_action :authenticate_user!, only: [:show, :index]
  protect_from_forgery except: :search

  def index
    if user_signed_in?
      if current_user.admin?
        @buses = Bus.paginate(page: params[:page], per_page: 5)
      elsif current_user.bus_owner?
        @buses = current_user.buses.paginate(page: params[:page], per_page: 5)
      else
        @buses = Bus.approved.paginate(page: params[:page], per_page: 5)
      end
    else
      @buses = Bus.approved.paginate(page: params[:page], per_page: 5)
    end
  end

  def reservations_list
    @date = params[:date]
    @bus = Bus.find(params[:bus_id])
    @reservations = @bus.reservations.where(date: @date)
    authorize @bus
  end

  def show
    @bus = Bus.find(params[:id])
    @reservations = @bus.reservations.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @today_tickets = @bus.reservations.where(date: Date.today)
    authorize @bus
  end

  def new
    @bus = Bus.new
    @bus.depart_time = Time.current.change(hour: 12, min: 0, sec: 0)
    authorize @bus
  end

  def create
    owner = BusOwner.find(current_user.id)
    @bus = owner.buses.new(bus_params)
    authorize @bus
    if @bus.save
      redirect_to bus_path(@bus), notice: "Bus Added Successfully"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def search
    @source = params[:source]
    @destination = params[:destination]
    @buses = Bus.where(source: @source.capitalize, destination: @destination.capitalize)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @bus = Bus.find_by(id: params[:id])
    authorize @bus
  end

  def update
    @bus = Bus.find_by(id: params[:id])
    authorize @bus
    if @bus.update(bus_params)
      redirect_to @bus, notice: "Bus Updated"
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @bus = current_user.buses.find(params[:id])
    authorize @bus
    @bus.destroy
    redirect_to buses_path, notice: "Trip Cancelled Successfully"
  end

  private
  def bus_params
    params.require(:bus).permit(:source, :destination, :depart_time, :bus_number, :capacity)
  end
end
