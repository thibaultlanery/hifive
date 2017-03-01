class EventsController < ApplicationController

before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      # create participation for each friend
      redirect_to event_path,  notice: "Event created! Here is your recap :)"
    else
      render :new , alert: "Ooooops, something missing! Please try again"
    end
  end

  def show

  end

  def edit

  end

  def update
    if @event.update(event_params)
      redirect_to event_path,  notice: "Event updated"
    else
      render :edit, alert: "event not updated"
    end
  end

  def destroy
    @event.canceled_at = Time.now
    redirect_to :index, notice: "Event cancelled"
  end

private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:happen_at, :canceled_at, :due_at, :user_id, :restaurant_id)
  end

end