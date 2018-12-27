class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      
      t.string :title
      t.text :body
      t.json :files
      t.integer :recruit_num
      t.text :place
      t.date :event_date
      t.date :deadline
      t.references :user

      t.timestamps
    end
  end
end
