class Ableton

	attr_accessor :file

	def initialize(file = "basic-midi-clip.xml" )
		@file = file
	end

	def path
		Rails.root.join("public/ableton/#{file}")
	end

	def xml
		Nokogiri::XML(File.open(path))
	end

	def loop_end
		( xml.xpath('//LoopEnd').first['Value'].to_i / 4).to_s + 'm'
	end

	def keys
		xml.xpath("//Notes//KeyTrack")
	end

	def midi_note
		xml.xpath('//MidiKey').first['Value']
	end

	def midi_events
		xml.xpath('//MidiNoteEvent')
	end

	def events_array
		array = []
		keys.each do |key|
			note = key.css('MidiKey').first['Value']
			note_name = midi_note_to_note_name(note)
			events = key.css('MidiNoteEvent')
			events.each do |event|
				time = event['Time']
				duration = event['Duration']
				array.push({ time: time.to_s + ' * 4n', note: note_name, duration: '16n' })
			end
		end
		return array
	end
	
	def midi_note_to_note_name(note)
		midi_converter_array[note.to_i]
	end


	def midi_converter_array
		array = []
		note_names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
		10.times do |i|
			note_names.each do |n|
				array.push( n + (i-2).to_s)
			end
		end
		return array
	end

end