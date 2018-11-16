class Ableton::AbletonClip < Ableton
	
	def initialize(clip_xml)
		@clip_xml = clip_xml
	end

	def clip_xml
		@clip_xml
	end

	def keys
		@clip_xml.css('KeyTrack')
	end

	def loop_end
		(@clip_xml.css('LoopEnd').first['Value'].to_i / 4).to_s + 'm'
	end

	def events(keys = self.keys)
		array = []
		keys.each do |key|
			note = key.css('MidiKey').first['Value']
			note_name = midi_note_to_note_name(note)
			events = key.css('MidiNoteEvent')
			events.each do |event|
				time = event['Time'].to_f
				duration = event['Duration'].to_f
				velocity = event['Velocity'].to_f/128
				array.push({ time: time, note: note_name, duration: duration, velocity: velocity })
			end
		end
		return array
	end

	def build_part(instrument)
		Part.new(instrument, events, true, loop_end)
	end

end