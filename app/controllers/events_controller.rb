class EventsController < ApplicationController
  def index
    @upcoming_events = Event.upcoming
    @prev_events = Event.past
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    begin
      @user = User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      @user = nil
    end

    if @user
      @event = @user.created_events.build(event_params)
      @user.save

      if @event.persisted?
        flash[:notice] = "Event created successfully"
        redirect_to event_path(@event)
      else
        flash[:notice] = "Couldn't create event"
        render :new
      end
    else
      flash[:notice] = 'Please sign in to create an event'
      redirect_to sign_in_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date)
  end
end
