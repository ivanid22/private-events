module InvitationsHelper
  def invitation_accept_path(invitation)
    "/invitations/#{invitation.id}/accept"
  end
  def invitation_message(invitation)
    if invitation.length === 0 
      "you have no invitations"
    else
        nil
     end
   
  end
end
