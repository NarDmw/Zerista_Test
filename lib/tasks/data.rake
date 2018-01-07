namespace :data do

  require 'csv'
  desc "Uploads from CSV file"
  task upload_from_csv: :environment do
    FILENAME = "#{Dir.pwd}/data/test_events.csv"

    data = CSV.read(FILENAME, headers: true)
    data.each{ |row|
      track = Track.find_or_create_by(name: row['track'])
      date = Date.parse(row['start']).to_date
      Session.create(date: date,
                     start_time: row['start'],
                     end_time: row['end'],
                     name: row['name'],
                     track_id: track.id)
    }
  end

end
