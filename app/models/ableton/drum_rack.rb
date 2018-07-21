class Ableton::DrumRack < Ableton
	def initialize(rack_xml)
		@rack_xml = rack_xml
	end

	def rack_xml
		@rack_xml
	end

	def sample_mapping
		branches = {}
		@rack_xml.css('DrumBranch').each do |xml|
			sample_file = xml.css('MultiSamplePart SampleRef FileRef Name').first['Value']
			note = xml.css('BranchInfo ReceivingNote').first['Value']
			branches[drum_track_note_to_note_name(note)] = sample_file
		end
		return branches
	end

	def build_sampler(sample_folder_path = '/samples/')
		mapping_with_folder_path = Hash[sample_mapping.map {
			|note, file_name| [note, sample_folder_path + file_name] }]
		Sampler.new(mapping_with_folder_path)
	end

end