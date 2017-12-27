def parse(lines)
  lines.map {|line| line.chomp.split(/\t/).map(&:to_i) }
end

def divides(numbers)
  numbers.permutation(2).find {|a, b| (a < b ? b.modulo(a) : a.modulo(b)).zero? }.minmax
end

def solve(arg)
  parse(arg).map {|numbers| divides(numbers) }.sum {|min, max| max / min }
end

input = File.readlines("input")
p solve(input)

__END__
if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_divides
      assert_equal [2, 8], divides([5, 9, 2, 8])
      assert_equal [3, 9], divides([9, 4, 7, 3])
      assert_equal [3, 6], divides([3, 8, 6, 5])
    end
  end
end
