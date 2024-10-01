class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.references :organizer, null: false, foreign_key: { to_table: :users }
      t.references :venue, null: true, foreign_key: true
      t.datetime :date
      t.monetize :price
      t.integer :max_attendees
      t.integer :status
      t.integer :mode

      t.timestamps
    end
  end
end
