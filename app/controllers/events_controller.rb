class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]
  # authorizing access to the events resource - only creator can access
  before_action :authorize_item, only: [:update, :edit, :destroy]

  def index
    @events = Event.all.order('created_at DESC')
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find_by(id:params[:id])
  end

  def update
    @event = Event.find_by(params[:id])
    if @event.nil?
      flash.alert = 'Event does not exist'
    elsif @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # check destroy worked and notify
  def destroy
    @event = Event.find_by(params[:id])
    if @event.nil?
      flash.alert = 'Event does not exist'
    elsif @event.destroy
      flash.notice = 'Event was deleted.'
    else
      flash.alert = 'Error - event was not deleted.'
    end
    redirect_to root_path, status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :description, :location, :date, :private)
  end

  def authorize_item
    unless @event.creator == current_user
      redirect_to @event, alert: 'You are not authorized do that.'
    end
  end

end