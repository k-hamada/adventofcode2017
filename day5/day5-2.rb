def step(list, pos)
  next_pos = pos + list[pos]
  list[pos] += list[pos] < 3 ? +1 : -1;
  [list, next_pos]
end

def parse(lines)
  lines.map(&:to_i)
end

def solve(arg)
  list, pos = parse(arg), 0
  outside = list.count
  count = 0
  until pos >= outside
    list, pos = step(list, pos)
    count += 1
  end
  count
end

input = File.readlines("input")
p solve(input)

__END__
if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 10, solve(["0","3","0","1","-3"])
    end
  end
end
