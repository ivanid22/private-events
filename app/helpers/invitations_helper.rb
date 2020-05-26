module InvitationsHelper
  def invitation_accept_path(invitation)
    "/invitations/#{invitation.id}/accept"
  end

  def invitation_message(invitation)
    'you have no invitations' if invitation.empty?
  end
end
