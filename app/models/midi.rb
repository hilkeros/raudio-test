class Midi

	attr_accessor :script

	def initialize(instrument)

		@instrument = instrument.identifier
		@script = ("<script id='MidiCode'>
								window.onload = function()
		  {
		    var midi_converter = " + self.midi_converter_array.to_s +
		    ";
		    if (navigator.requestMIDIAccess) {
		          console.log('Browser supports MIDI!');
		        }

		    if (navigator.requestMIDIAccess) {
		      navigator.requestMIDIAccess()
		        .then(success, failure);
		    }

		    function success (midi) {
		      console.log('Got midi!');

		      var inputs = midi.inputs.values();
		      for (var input = inputs.next();
		        input && !input.done;
		        input = inputs.next()) {
		        input.value.onmidimessage = onMIDIMessage;
		        function onMIDIMessage (message) {
		          console.log(message.data);
		          if (message.data[0] === 144) {
		            playNote(message.data[1]);
		          }
		          if (message.data[0] === 128) {
		            stopNote(message.data[1]);
		          }
		        }
		      }

		    }

		    function failure () {
		          console.error('No access to midi devices')
		    }

		    function playNote(note) {" + @instrument +

	    	".triggerAttack(midi_converter[note]);
					}

  			function stopNote(note) {" + @instrument +

				".triggerRelease(midi_converter[note]);
			}
		}</script>").html_safe

	end

	def midi_note_to_note_name(note)
		midi_converter_array[note]
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
