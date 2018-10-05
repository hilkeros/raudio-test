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
		//should be start_in_session, but for that we need to know to which track the part belongs
		start_in_session(part, part.track); 
	})
}

function to_tone_values(events) {
	new_map = []
	events.forEach(function (event) {
		new_time = event['time'] * Tone.Time('4n')
		new_event = {'time': new_time, 'note': event['note'], 'duration': event['duration']}
		new_map.push(new_event);
	})
	return new_map
}

// function to_tone_values(events) {
//   return events.map(function(event) {
//     { 'time': event.time * Tone.Time('4n'), 'note': event.note, 'duration': event.duration }
//   })
// }