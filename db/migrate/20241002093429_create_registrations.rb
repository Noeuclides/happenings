class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end

    add_index :registrations, [:user_id, :event_id], unique: true
  end
end
