require 'spec_helper'

describe Matrix do
	it "fills matrix with values" do
		matrix = Matrix.new 8
    matrix_test_string = matrix.matrix.map {|x| x.join}.join
		expect(matrix_test_string.size).to eq 8 * 8
	end
end
