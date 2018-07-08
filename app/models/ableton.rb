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

	def midi_tracks
		tracks = []
		xml_tracks = xml.css('MidiTrack')
		xml_tracks.each do |xml|
			tracks.push(Ableton::AbletonTrack.new(xml))
		end
		return tracks
	end

	def build_session
		this_session = {}
		midi_tracks.each_with_index do |track, index|
			track_array = []
			track.clip_slots.each do |slot|
				track_array.push(slot)
			end
			this_session[index] = track_array
		end
		return this_session
	end

	def build_session_for_instruments(*instruments)
		s = self.build_session
		parts = []
		parts_lists = []
		instruments.each_with_index do |instrument, index|
			track = []
			s[index].each do |slot|
      	part = slot.build_part(instrument)
      	parts.push(part)
      	track.push(part)
    	end
    	parts_list = Ableton::PartsList.new(track)
    	parts_lists.push(parts_list)
    end
		return parts, parts_lists 
	end

	def midi_note_to_note_name(note)
		midi_converter_array[note.to_i]
	end

	#converts the Ableton xml durations to Tone.js notation with n and m
	def duration_converter(ableton_value)
		if ableton_value.to_f < 4
			((1/ableton_value.to_f) * 4).to_i.to_s + 'n'
		else
			(ableton_value.to_f/4).to_i.to_s + 'm'
		end
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