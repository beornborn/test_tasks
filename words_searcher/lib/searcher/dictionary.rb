class Dictionary
	attr_accessor :entries

	def initialize file
		@file = file
		@entries = []
		read_entries
	end

	def read_entries
		File.readlines(@file).each do |line|
			terms = line.split(" ")
			unless terms.empty?
				word = terms.first
				explanation = (terms - [terms.first]).join(" ")
				@entries << { word: terms.first, explanation: explanation }
			end
		end
	end
end
