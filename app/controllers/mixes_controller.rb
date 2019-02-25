class MixesController < ApplicationController

	def create
		@mix = Mix.create(mix_params)
		@mix.update_attributes(knobs: JSON.parse(params[:knobs]))
	end

	def show
		if params[:mix_id].present?
			@mix = Mix.find(params[:mix_id]) 
		else
			@mix = Mix.find(params[:id])
		end

		respond_to do |format|
			format.js
			format.json { render json: @mix.to_json}
		end
	end

	def update
		@mix = Mix.find(params[:id])
		@mix.update_attributes(knobs: JSON.parse(params[:knobs])	)	
	end

	def mix_params
		params.require(:mix).permit(:name, :file, :knobs)
	end
end