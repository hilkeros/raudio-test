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

function to_tone_values(events) {
  return events.map(function(event) { return {time: event.time * Tone.Time('4n'), note: event.note, duration : event.duration} });
}
