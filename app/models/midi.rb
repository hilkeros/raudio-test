class Midi

	attr_accessor :script

	def initialize(instrument)

		@instrument = instrument.identifier
		@script = ("<script id='MidiCode'>
								window.onload = function()
		  {
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
		        //call the midi message
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

	    	".triggerAttack(note);
					}

  			function stopNote(note) {" + @instrument +

				".triggerRelease();
			}
				}</script>").html_safe

	end
end
