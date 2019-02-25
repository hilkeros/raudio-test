class Ableton::AbletonTrack < Ableton

	def initialize(track_xml)
		@track_xml = track_xml
	end

	def track_xml
		@track_xml
	end

	def clip_slots
		slots = []
		xml_slots = @track_xml.css('ClipSlot ClipSlot MidiClip')
		xml_slots.each do |xml|
			slots.push(Ableton::AbletonClip.new(xml))
		end
		return slots
	end

	def drum_rack
		 Ableton::DrumRack.new(@track_xml.css('DrumGroupDevice'))
	end

	def simpler
		unless @track_xml.css('DrumGroupDevice').present?
			Ableton::Simpler.new(@track_xml)
		end
	end

	def to_json
		{
			drum_rack: drum_rack.sample_mapping,
			simpler: simpler.to_json,
			events: clip_slots.map{|s| s.events}
		}
	end
	
end