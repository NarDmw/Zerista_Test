json.extract! session, :id, :start_time, :end_time, :name, :track_id, :created_at, :updated_at
json.url session_url(session, format: :json)
