class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      #adding in the same information so when a query for sessions by date doesn't require unnecessary
      # conversion on start_time or end_time
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.references :track, foreign_key: true

      t.timestamps
    end
  end
end
