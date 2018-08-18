class RulumuController < ApplicationController
	def paradoxes
		a = Ableton.new('paradoxes.als')
		@beat = a.midi_tracks[0].drum_rack.build_sampler('/samples/rulumu/')
		@snare = a.midi_tracks[1].drum_rack.build_sampler('/samples/rulumu/')
		@pad = AMSynth.new
		#@east = a.midi_tracks[4].simpler.build_sampler('/samples/rulumu/')
		@beat.to_master
		@snare.to_master
		@pad.to_master
		#@east.to_master

		parts, tracks, scenes = a.build_session_for_instruments(@beat, @snare, @pad)
		@raudio = Audio.new.render(@beat, @snare, @pad, *parts, *tracks, *scenes)

		@nexus = Nexus.new.render(
        @start_track_1_clip_1 = NxButton.new(parts[0].start_in_session(tracks[0])),
        @start_track_1_clip_2 = NxButton.new(parts[1].start_in_session(tracks[0])),
        @start_track_2_clip_1 = NxButton.new(parts[2].start_in_session(tracks[1])),
        @start_track_2_clip_2 = NxButton.new(parts[3].start_in_session(tracks[1])),
        @start_track_2_clip_3 = NxButton.new(parts[4].start_in_session(tracks[1])),
        @start_scene_1 = NxButton.new(scenes[0].start_scene),
        @start_scene_2 = NxButton.new(scenes[1].start_scene),
        @start_scene_3 = NxButton.new(scenes[2].start_scene),
        )
	end
end