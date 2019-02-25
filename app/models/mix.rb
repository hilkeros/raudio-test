class Mix < ApplicationRecord

	def to_json
		{
			knobs: self.knobs,
			ableton: ableton.to_json
		}
	end

	def ableton
		Ableton.new(self.file)
	end
end
