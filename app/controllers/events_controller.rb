class EventsController < ApplicationController

    def index
        @events = Event.all
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
      
      if  @user 

       @event = @user.created_events.build(event_params)
       @user.save

       redirect_to event_path(@event)
      else
        redirect_to sign_in_path
      end
      
    end

    private

    def event_params
        params.require(:event).permit(:title, :description, :date)
    end
end
