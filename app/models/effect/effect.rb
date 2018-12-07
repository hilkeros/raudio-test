class Effect < Audio
	attr_accessor :bus_name

	def make_bus(bus_name)
		@scripts << "#{identifier}.receive('#{bus_name}').toMaster();"
		self.bus_name = bus_name
	end
end