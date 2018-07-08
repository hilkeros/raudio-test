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

	


end