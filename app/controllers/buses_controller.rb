class BusesController < ApplicationController

  before_action :authenticate_user!, only: [:show, :index]
  protect_from_forgery except: :search

  def index
    if user_signed_in?
      if current_user.admin?
        @buses = Bus.upcoming.paginate(page: params[:page], per_page: 5)
      elsif current_user.bus_owner?
        @buses = current_user.buses.upcoming.paginate(page: params[:page], per_page: 5)
      else
        @buses = Bus.approved.upcoming.paginate(page: params[:page], per_page: 5)
      end
    else
      @buses = Bus.approved.upcoming.paginate(page: params[:page], per_page: 5)
    end
  end

  def show
    @bus = Bus.find(params[:id])
    @reservations = @bus.reservations.paginate(page: params[:page], per_page: 5)
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
    date = params[:search_date]
    # binding.pry
    if (date.present? && date > Time.now)
      @date = Date.parse(date)
      authorize current_user, :all_users?
      @buses = Bus.approved.on_date(@date)
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to buses_path, alert: "Enter valid date!!"}
          format.js
        end
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
    params.require(:bus).permit(:source, :destination, :depart_time, :bus_number, :journey_date, :capacity)
  end
end
