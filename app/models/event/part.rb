class Part < Audio

	attr_accessor :event, :interval, :scripts
	def initialize(instrument, midi_events = [])
		@instrument = instrument.identifier
		@midi_events = midi_events.to_json
	

		@scripts = ["var #{identifier} = new Tone.Part(function(time, event){
							#{@instrument}.triggerAttackRelease(event.note, event.duration, time)
							}, JSON.parse('#{@midi_events}')); #{identifier}.loop = true;
				"]
	end

	def identifier
		"part_" + object_id.to_s
	end
end