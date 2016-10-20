class EventsController < ApplicationController
  
  before_action :require_login

  def index
    @user = current_user
    @localEvents = Event.where(state: @user.state)
    @otherEvents = Event.where.not(state: @user.state)
    @rsvp = Rsvp.new
    @event = Event.new
    @states = State.all
  end

  def create
    e_params = event_params
    e_params['user'] = current_user
    e_params['state'] = State.find(event_params['state_id'].to_i)
    e_params['date'] = Date.parse(event_params['date'])
    e_params.delete('state_id')
    puts Date.parse(event_params['date'])
    puts e_params['date']
    puts Date.today
    @event = Event.new( e_params )
    if @event.save
      redirect_to events_path
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    @states = State.all
  end

  def update
    @event = Event.find(params[:id])
    e_params = event_params
    puts e_params
    e_params['state'] = State.find(event_params[:state_id].to_i)
    e_params['date'] = Date.parse(event_params['date'])
    e_params.delete('state_id')
    if @event.update( e_params )
      redirect_to events_path
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    Event.find(params[:id]).destroy if Event.find(params[:id]).user == current_user
    redirect_to events_path
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state_id)
    end

end
