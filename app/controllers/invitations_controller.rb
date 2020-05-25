class InvitationsController < ApplicationController

  def index
    if session[:user_id]
      @invitations = User.find(session[:user_id]).unaccepted_invitations
    else
      redirect_to sign_in_path
    end
  end
  
  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.accepted = true

    if @invitation.save
        flash[:success] = "Invitation accepted"
      else
        flash[:error] = "Something went wrong"
    end
    redirect_to invitations_path
  end

  def new
    redirect_to sign_in_path if session[:user_id].nil?
    @invitation = Invitation.new
  end

  def create
      @invitation = Invitation.new(invitation_params)

      if @invitation.save
        flash[:success] = "Invitation successfully created"
        redirect_to events_path
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
  end

  def destroy
      @invitation = Invitation.find(params[:id])
      if @invitation.destroy
          flash[:success] = 'Invitation was declined.'
          redirect_to invitations_path
      else
          flash[:error] = 'Something went wrong'
          redirect_to invitations_path
      end
  end
  
  private

  def invitation_params
    params.require(:invitation).permit(:id, :attendee_id, :attended_event_id)
  end
  
end
