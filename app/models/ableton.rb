class Ableton

	attr_accessor :file, :instruments

	def initialize(file = "basic-midi-clip.xml", instruments = [] )
		@file = file
		@instruments = instruments
	end

	def path
		Rails.root.join("public/ableton/#{file}")
	end

	def xml
		if File.extname(path) == ('.xml')
			Nokogiri::XML(File.open(path))
		elsif File.extname(path) == '.als'
			xml_file = @file.gsub('.als', '.xml')
			xml_path = Rails.root.join("public/ableton/#{xml_file}")
			# check if an xml version was already created
			if File.file?(xml_path)
				Nokogiri::XML(File.open(xml_path))
			else
				# rename and unzip
				renamed_file = @file.gsub('.als', '.gzip')
				renamed_path = Rails.root.join("public/ableton/#{renamed_file}")
				File.rename(path, renamed_path)
				gzip = File.open(renamed_path)
				unzipped = Zlib::GzipReader.new(StringIO.new(gzip.read)).read
				# create xml version
				xml_file = File.write(xml_path, unzipped)
				# rename back to .als
				File.rename(renamed_path, path)
				Nokogiri::XML(unzipped)
			end
		else
			raise "Can't read file"
		end
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
    	track.each do |part|
    		part.track = parts_list
    	end
    	tracks.push(parts_list)
    end
    scenes = []
    scenes_hash.each do |key, parts|
    	scene = Ableton::PartsList.new(parts)
    	scenes.push(scene)
    end
    tracks.each do |track|
    	track.link_parts_to_track
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

	def build_interface(parts, tracks, scenes)
    buttons = []
    dials = []

    scenes.each do |scene|
    	row = []
    	scene.parts.each do |part|
    		part_button = NxButton.new(part.start_in_session(part.track))
    		row.push(part_button)
    	end
    	scene_button = NxButton.new(scene.start_scene)
    	row.push(scene_button)
    	buttons.push(row)
    end

    # track titles
    grid = "<table><tr><td></td>"
    tracks.count.times do |i|
    	grid << "<td>t#{i + 1}</td>"
  	end
  	grid << "<td>master</td></tr>"
  	# volume dials
  	if @instruments.present?
  		grid << "<tr><td>vol</td>"
  		@instruments.count.times do |i|
  			dial = NxDial.new(instruments[i], 'volume', {'min': -30, 'max': 6})
  			grid << "<td><span id='#{dial.identifier}'></span><br>
  			&nbsp; <span id='number_#{dial.identifier}'></span></td>"
  			dials.push(dial)
  		end
  	end
  	# scene buttons
  	buttons.each_with_index do |row, index|
  		grid << "<tr><td>s#{index + 1}</td>"
  			row.each do |btn|
  				grid << "<td><div id='#{btn.identifier}'></div></td>"
  			end
  		grid << "</tr>"
  	end
  	grid << "</table>"
  	grid = grid.html_safe

  	nexus = Nexus.new.render(*dials, *buttons.flatten)
  	return nexus, grid

	end

end