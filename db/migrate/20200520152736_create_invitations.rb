class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|

      t.timestamps
      t.integer :attended_event_id
      t.integer :attendee_id
      t.boolean :accepted
      
    end
  end
end
