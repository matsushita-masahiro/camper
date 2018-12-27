class CreateEventMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :event_members do |t|
      
      t.references :event
      t.references :user
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
