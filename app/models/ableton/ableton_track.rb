class AbletonTrack < Ableton

	def initialize(track_xml)
		@track_xml = track_xml
	end

	def track_xml
		track_xml
	end

	def keys
		@track_xml.css('KeyTrack')
	end

	def loop_end
		(@track_xml.css('LoopEnd').first['Value'].to_i / 4).to_s + 'm'
	end

end