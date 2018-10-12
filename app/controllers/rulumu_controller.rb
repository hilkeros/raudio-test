class RulumuController < ApplicationController
	def paradoxes
		ableton = Ableton.new('paradoxes simplers only.als')

    beats 	= 	ableton.midi_tracks[0].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	snare 	= 	ableton.midi_tracks[1].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	pad 		= 	ableton.midi_tracks[2].simpler.build_sampler('/samples/rulumu/mp3/')
   	bell 		= 	ableton.midi_tracks[3].simpler.build_sampler('/samples/rulumu/mp3/')
   	east 		= 	ableton.midi_tracks[4].simpler.build_sampler('/samples/rulumu/mp3/')
   	hihat 	= 	ableton.midi_tracks[5].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	low_c 	= 	ableton.midi_tracks[6].simpler.build_sampler('/samples/rulumu/mp3/')
   	high_c 	= 	ableton.midi_tracks[7].simpler.build_sampler('/samples/rulumu/mp3/')


   	beats.to_master
   	snare.to_master
   	pad.to_master
   	bell.to_master
   	east.to_master
   	hihat.to_master
   	low_c.to_master
   	high_c.to_master

   	parts, tracks, scenes = ableton.build_session_for_instruments(beats, snare, pad, bell, east, hihat, low_c, high_c)
    @raudio = Audio.new(bpm: 80).render(beats, snare, pad, bell, east, hihat, low_c, high_c, *parts, *tracks, *scenes)

    @nexus, @grid = ableton.build_interface(parts, tracks, scenes)
	end
end