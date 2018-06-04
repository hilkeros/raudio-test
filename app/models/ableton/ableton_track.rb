class AbletonTrack < Ableton

	def initialize(track_xml)
		@track_xml = track_xml
	end

	def track_xml
		@track_xml
	end

	def keys
		@track_xml.css('KeyTrack')
	end
end