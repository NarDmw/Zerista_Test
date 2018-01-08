class Track < ApplicationRecord
  SPECIAL_TRACKS = ['Coffee Breaks', 'Lunch', 'Party', 'Keynote']

  def self.span_all_line_ids
    SPECIAL_TRACKS.map { |track_name| Track.find_by(name: track_name).id }
  end
end
