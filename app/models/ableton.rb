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
		tracks = []
		scenes_hash = {}
		instruments.each_with_index do |instrument, index|
			track = []
			s[index].each_with_index do |slot, j|
      	part = slot.build_part(instrument)
      	parts.push(part)
      	track.push(part)
      	if scenes_hash[j].blank?
      		scenes_hash[j] = [part]
      	else
      		scenes_hash[j] = scenes_hash[j].push(part)
    		end 
    	end
    	parts_list = Ableton::PartsList.new(track)
    	tracks.push(parts_list)
    end
    scenes = []
    scenes_hash.each do |key, parts|
    	scene = Ableton::PartsList.new(parts)
    	scenes.push(scene)
    end
		return parts, tracks, scenes
	end

	def midi_note_to_note_name(note)
		midi_converter_array[note.to_i]
	end

	def drum_track_note_to_note_name(note)
		midi_converter_array.reverse[note.to_i - 9]
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