class Calculator
	attr_reader :stack

	def initialize
		@stack = []
		start
	end

	private
		def start
			ARGF.each do |input|
				input = input.gsub(/\n/, '')
				break if input == 'q'
				if is_number?(input)
					stack.push(input.to_f)
				elsif is_operator?(input)
					n2 = stack.pop
					n1 = stack.pop
					if n1 && n2
						n = n1.send(input, n2)
						n = sanitize(n)
						stack.push(n)
						puts n
					elsif n2
						stack.push(n2)
						p stack
						puts n2
					end
				end
			end
		end

		def is_number?(s)
			s.to_f.to_s == s || s.to_i.to_s == s
		end

		def is_operator?(s)
			['+', '-', '*', '/'].include?(s)
		end

		def sanitize(n)
			if n.to_i == n
				return n.to_i
			else
				return n
			end
		end
end

calculator = Calculator.new