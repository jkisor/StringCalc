module StringCalculator
	def add
		return 0 if empty?
		raise_if_negatives_present
		numbers.inject { |sum, n| sum + n }
	end
	def negatives
		numbers.select {|x| x < 0 }
	end
	def numbers
		d = delimiter
		gsub("\n", d).split(d).map { |x| x.to_i }
	end

	def delimiter
		if self[0,2] == "//"
			return self[2,1];
		end
		','
	end

	def raise_if_negatives_present
		neg_nums = negatives
		if(neg_nums.any?)
			raise "Negatives not allowed: #{neg_nums.join(', ')}"
		end
	end
end

class String
	include StringCalculator
end