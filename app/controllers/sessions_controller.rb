class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
  def index
    #sets the default view date
    params['view_date'] ||= '2015-08-12'
    @date = Date.parse(params['view_date'])
    @sessions = Session.where(date: @date)

    special_tracks = ['Coffee Breaks', 'Lunch', 'Party', 'Keynote']
    special_track_ids = special_tracks.map{ |track_name| Track.find_by(name: track_name).id }

    track_ids = @sessions.pluck(:track_id).uniq.reject{|id| special_track_ids.include?(id)}.sort
    @tracks = track_ids.each_with_index.map { |id, index| [id, [Track.find(id).name, index]] }.to_h

    @time_slots_with_sessions = @sessions.each_with_object(Hash.new{|h,k| h[k] = []}){ |session, obj|
      time_range = "#{session.start_time.strftime("%H:%M %p")} to #{session.end_time.strftime("%H:%M %p")}"

      if special_track_ids.include?(session.track_id)
        @tracks.each_with_index { |_, track_index|
          obj[time_range] << [track_index, session.name]
        }
      else
        track_index = @tracks[session.track_id][1]
        obj[time_range] << [track_index, session.name]
      end
    }
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:session).permit(:start_time, :end_time, :name, :track_id)
  end
end
