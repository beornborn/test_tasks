class Searcher
	attr_accessor :matrix, :dictionary_entries

	def initialize length, dictionary
		@matrix = Matrix.new(length).matrix
		@dictionary_entries = Dictionary.new(dictionary).entries
	end

	def horizontal_words_from_left_to_right
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if j == matrix.length - 1

				candidates << matrix[i][j] + matrix[i][j+1]
			end
		end

		entries_from_candidates candidates
	end

	def horizontal_words_from_right_to_left
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if j == matrix.length - 1

				candidates << matrix[i][j+1] + matrix[i][j]
			end
		end

		entries_from_candidates candidates
	end

	def vertical_words_from_top_to_bottom
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if i == matrix.length - 1

				candidates << matrix[i][j] + matrix[i+1][j]
			end
		end

		entries_from_candidates candidates
	end

	def vertical_words_from_bottom_to_top
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if i == matrix.length - 1

				candidates << matrix[i+1][j] + matrix[i][j]
			end
		end

		entries_from_candidates candidates
	end

	def diagonal_words_from_left_to_right
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if j == matrix.length - 1 or i == matrix.length - 1

				candidates << matrix[i][j] + matrix[i+1][j+1]
			end
		end

		entries_from_candidates candidates
	end

	def diagonal_words_from_right_to_left
		candidates = []

		matrix.each_with_index do |line,i|
			line.each_with_index do |val, j|
				# exclude impossible values for pairs
				next if j == matrix.length - 1 or i == matrix.length - 1

				candidates << matrix[i+1][j+1] + matrix[i][j]
			end
		end

		entries_from_candidates candidates
	end

	private

	def entries_from_candidates candidates
		entries_found = []

		dictionary_entries.each do |entry|
			entries_found << entry if candidates.include? entry[:word]
		end

		entries_found
	end
end
