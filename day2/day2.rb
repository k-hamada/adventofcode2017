def parse(lines)
  lines.map {|line| line.chomp.split(/\t/).map(&:to_i) }
end

def solve(arg)
  parse(arg).map(&:minmax).sum {|min, max| max - min }
end

input = File.readlines("input")
p solve(input)

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 18, solve(["5\t1\t9\t5\n", "7\t5\t3\n", "2\t4\t6\t8\n"])
    end
  end
end
