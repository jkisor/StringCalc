require("string_calculator")

RSpec::Matchers.define :add_up_to do |expected|
	match do |string|
		@result = string.add
		@result == expected
	end

	failure_message_for_should do |string|
		"Expected #{string} to add up to #{expected}, but got #{@result}"
  	end
end

describe StringCalculator do
	describe "#add" do
		it "returns 0 for an empty string" do
			expect("").to add_up_to(0)
		end

		context "single number" do
			it "returns 0 for 0" do
				expect("0").to add_up_to(0)
			end

			it "returns 2 for 2" do
				expect("2").to add_up_to(2)
			end

			it "returns 33 for 33" do
				expect("33").to add_up_to(33)
			end
		end

		context "two numbers" do
			it "returns 7 for 4,3" do
				expect("4,3").to add_up_to(7)
			end

			it "returns 22 for 10,12" do
				expect("10,12").to add_up_to(22)
			end
		end

		context "three numbers" do
			it "returns 100 for 10, 40, 50" do
				expect("10,40,50").to add_up_to(100)
			end

			it "returns 1111 for 100, 11, 1000" do
				expect("100,11,1000").to add_up_to(1111)
			end
		end

		it "supports newline as a delimiter" do
			expect("1\n2").to add_up_to(3)
		end

		it "supports mixed delimiters" do
			expect("2\n2,2").to add_up_to(6)
		end

		it "supports custom delimiter" do
			expect("//;\n1;1;1").to add_up_to(3)
		end

		context "negative numbers" do
			it "raises an exception if it finds a negative" do
				expect { "-1".add }.to raise_error
			end
			it "numbers are included in exception message" do
				expect {"-1, -2, 4".add}.to raise_error("Negatives not allowed: -1, -2")
			end
		end
	end	
end