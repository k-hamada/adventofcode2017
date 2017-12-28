require 'set'

def step(banks)
  new_banks = banks.dup
  redistribution_bank = redistribution(banks)
  new_banks[redistribution_bank.last] = 0
  redistribution_bank.first.times do |i|
    index = redistribution_bank.last + i + 1
    index %= new_banks.size if index >= new_banks.size
    new_banks[index] += 1
  end
  new_banks
end

def redistribution(banks)
  banks.map.with_index.max_by {|e, i| e }
end

def parse(lines)
  lines.split(/\t/).map(&:to_i)
end

def solve(arg)
  set = Set.new
  hist = {}
  banks = parse(arg.first)
  count = 0
  while set.add?(banks)
    hist[banks] = count
    banks = step(banks)
    count += 1
  end
  count - hist[banks]
end

input = File.readlines("input")
p solve(input)

__END__

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 4, solve(["0\t2\t7\t0"])
    end

    def test_redistribution
      assert_equal [7, 2], redistribution([0, 2, 7, 0])
      assert_equal [4, 1], redistribution([2, 4, 1, 2])
      assert_equal [3, 0], redistribution([3, 1, 2, 3])
    end

    def test_step
      assert_equal [2, 4, 1, 2], step([0, 2, 7, 0])
      assert_equal [3, 1, 2, 3], step([2, 4, 1, 2])
      assert_equal [0, 2, 3, 4], step([3, 1, 2, 3])
      assert_equal [1, 3, 4, 1], step([0, 2, 3, 4])
      assert_equal [2, 4, 1, 2], step([1, 3, 4, 1])
    end
  end
end
