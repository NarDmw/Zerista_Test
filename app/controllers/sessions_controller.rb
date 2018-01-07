class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
  def index
    date1 = Date.parse("2015-08-12")
    @sessions = Session.where(date: date1)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:start_time, :end_time, :name, :track_id)
    end
end
