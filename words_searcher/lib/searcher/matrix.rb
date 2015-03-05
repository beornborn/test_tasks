class Matrix
	attr_accessor :matrix

	def initialize length
		@matrix = [[nil] * length.to_i] * length.to_i
		fill
	end

	def fill
		self.matrix.map! do |arr|
			arr.map do |_|
				("A".."Z").to_a.sample
			end
		end
	end
end
