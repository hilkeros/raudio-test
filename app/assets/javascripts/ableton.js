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