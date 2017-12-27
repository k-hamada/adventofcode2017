def severity(depth, range)
  if depth % ((range - 1) * 2) == 0
    depth * range
  else
    0
  end
end

def parse(arg)
  arg.split(/\n/).map {|line| line.split(": ").map(&:to_i) }
end

def solve(arg)
  parse(arg).sum {|d, r| severity(d, r) }
end

input = File.read("input")
p solve(input)

__END__
if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 0, severity(0, 3)
      assert_equal 0, severity(1, 2)
      assert_equal 0, severity(4, 4)
      assert_equal 24, severity(6, 4)
    end
  end
end
