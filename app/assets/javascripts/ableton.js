function start_in_session(part, track) {
	track.forEach(function (this_part) {
		if (this_part == part) {
			this_part.start('@1m');
		} else {
			this_part.stop('@1m');
		}
	})
}

function start_scene(scene) {
	scene.forEach(function (part) {
		start_in_session(part, part.track); 
	})
}

function stop_all_parts(track) {
	track.forEach(function (this_part) {
		this_part.stop('@1m');
	})
}

function to_tone_values(events) {
  processed = events.map(function(event) { return {time: event.time * Tone.Time('4n'), 
  	note: event.note, duration : event.duration * Tone.Time('4n'), velocity: event.velocity }});
  return processed;
}

function get_knobs() {
	$('.getKnobs').submit( function (event){
		volumes = [];
		sends = [];
		$('.volume').each(function() {
			v = window[$(this).attr('id')].value;
			volumes.push(v);
		});
		$('.send').each(function() {
			v = window[$(this).attr('id')].value;
			sends.push(v);
		})
		knobs = JSON.stringify({volumes: volumes, sends: sends})
		$('<input />').attr('type', 'hidden')
          .attr('name', "knobs")
          .attr('value', knobs)
          .appendTo($(this));
	});
}

$( document ).ready(function() {
	get_knobs();
});
