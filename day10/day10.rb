def step(list, pos, length, skip)
  if list.size <= pos + length
    head = 0...(pos + length - list.size)
    tail = pos...list.size
    r = (list[tail] + list[head]).reverse
    list[tail] = r[0, tail.size]
    list[head] = r[tail.size, head.size]
  else
    list[pos, length] = list[pos, length].reverse
  end
  next_pos = (length + skip + pos) % list.size
  [list, next_pos]
end

def solve(arg)
  list, pos = [*0..255], 0
  arg.split(/,/).map(&:to_i).each.with_index do |l, i|
    list, pos = step(list, pos, l, i)
  end
  list[0] * list[1]
end

input = File.readlines("input")
p solve(input.first)

__END__

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal [[2,1,0,3,4], 3], step([0,1,2,3,4], 0, 3, 0)
      assert_equal [[4,3,0,1,2], 3], step([2,1,0,3,4], 3, 4, 1)
      assert_equal [[4,3,0,1,2], 1], step([4,3,0,1,2], 3, 1, 2)
      assert_equal [[3,4,2,1,0], 4], step([4,3,0,1,2], 1, 5, 3)
    end
  end
end
