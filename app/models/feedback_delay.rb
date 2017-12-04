class FeedbackDelay < Audio
	attr_accessor :delay_time, :feedback, :scripts

	def initialize(delay_time = 0.25, feedback)
		@delay_time = delay_time
		@feedback = feedback
		@scripts = ["var #{identifier} = new Tone.FeedbackDelay(
									'#{@delay_time}', #{@feedback});"]
	end

	def identifier
		"feedback_delay_" + object_id.to_s
	end


end
