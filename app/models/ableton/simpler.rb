class Ableton::Simpler < Ableton
	def initialize(rack_xml)
		@rack_xml = rack_xml
	end

	def rack_xml
		@rack_xml
	end

	def sample_file
		xml = @rack_xml.css('MultiSamplePart SampleRef FileRef Name')
		if xml.present?
			xml.first['Value']
		end
	end

	def root_key
		xml = @rack_xml.css('MultiSamplePart RootKey')
		if xml.present?
			drum_track_note_to_note_name(xml.first['Value'])
		end
	end


	def build_sampler(sample_folder_path = '/samples/')
		Sampler.new('C3' => sample_folder_path + self.sample_file )
	end

	def to_json
		{file: sample_file, root_key: root_key}
	end
end