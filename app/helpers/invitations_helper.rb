module InvitationsHelper
  def invitation_accept_path(invitation)
    "/invitations/#{invitation.id}/accept"
  end
end
