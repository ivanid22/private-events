class AddDefaultToAcceptInvitation < ActiveRecord::Migration[6.0]
  def change
    change_column :invitations, :accepted, :boolean, :default => false
  end
end
