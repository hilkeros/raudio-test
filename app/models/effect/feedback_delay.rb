class FeedbackDelay < Effect
	attr_accessor :delayTime, :feedback, :scripts

	def initialize(delayTime = 0.25, feedback)
		@delayTime = delayTime
		@feedback = feedback
		@scripts = ["var #{identifier} = new Tone.FeedbackDelay(
									'#{delayTime}', #{@feedback});"]
	end

	def identifier
		"feedback_delay_" + object_id.to_s
	end


end
