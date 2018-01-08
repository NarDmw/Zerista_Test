class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
  def index
    #sets the default view date
    params['view_date'] ||= '2015-08-12'
    @date = Date.parse(params['view_date'])

    #sessions that are relevant to view_date
    sessions = Session.where(date: @date)

    #unique track ids that aren't included across all time slots
    track_ids = sessions.pluck(:track_id).uniq.reject{|id| Track.span_all_line_ids.include?(id)}.sort

    # key = track_id in database
    # value = [track_name, html_column index + 1]
    @tracks = track_ids.each_with_index.map { |id, index| [id, [Track.find(id).name, index]] }.to_h

    #populates the data structure that is needed for the layout
    # key = time slot in form of a string
    # value = [column index + 1, name of the session]
    @time_slots_with_sessions = sessions.each_with_object(Hash.new{|h,k| h[k] = []}){ |session, obj|
      time_range = "#{session.start_time.strftime("%H:%M %p")} to #{session.end_time.strftime("%H:%M %p")}"

      if Track.span_all_line_ids.include?(session.track_id)
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
