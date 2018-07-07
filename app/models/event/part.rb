class Part < Audio

	attr_accessor :event, :interval, :scripts
	def initialize(instrument, midi_events = [], loop = false, loopEnd = '1m')
		@instrument = instrument.identifier
		@midi_events = midi_events.to_json
		@loop = loop
		@loopEnd = loopEnd
	

		@scripts = ["var #{identifier} = new Tone.Part(function(time, event){
							#{@instrument}.triggerAttackRelease(event.note, event.duration, time)
							}, JSON.parse('#{@midi_events}')); 
							#{identifier}.loop = #{@loop};
							#{identifier}.loopEnd = '#{@loopEnd}';
				"]
	end

	
	 def start_in_session(partslist)
    script = "start_in_session(#{self.identifier}, #{partslist.identifier})"
  end

	def identifier
		"part_" + object_id.to_s
	end
end