class MixesController < ApplicationController

	def create
		@mix = Mix.create(mix_params)
		@mix.update_attributes(knobs: JSON.parse(params[:knobs]))
	end

	def show
		@mix = Mix.find(params[:mix_id])
	end

	def update
		@mix = Mix.find(params[:id])
		@mix.update_attributes(knobs: JSON.parse(params[:knobs])	)	
	end

	def mix_params
		params.require(:mix).permit(:name, :file, :knobs)
	end
end