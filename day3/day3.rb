def taxicab_metric(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

# https://www.geeksforgeeks.org/find-coordinates-prime-number-prime-spiral/
def spiral_coordinate(i)
  i -= 1
  step_count = 1
  step_limit = 2
  adder = 1
  x, y = 0, 0
  (2..i + 1).each do |n|
    if (step_count <= 0.5 * step_limit)
      x += adder
    elsif (step_count <= step_limit)
      y += adder
    end

    if (step_count == step_limit)
      adder *= -1
      step_limit += 2
      step_count = 0
    end
    step_count += 1
  end
  [x, y]
end

def solve(n)
  taxicab_metric([0, 0], spiral_coordinate(n))
end

p solve(368078)

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_spiral_coordinate
      assert_equal [0, 0], spiral_coordinate(1)
      assert_equal [2, 1], spiral_coordinate(12)
      assert_equal [0, -2], spiral_coordinate(23)
      assert_equal [-15, 16], spiral_coordinate(1024)
    end

    def test_taxicab_metric
      assert_equal 0, taxicab_metric([0, 0], [0, 0])
      assert_equal 3, taxicab_metric([0, 0], [2, 1])
      assert_equal 2, taxicab_metric([0, 0], [0, -2])
      assert_equal 31, taxicab_metric([0, 0], [-15, 16])
    end

    def test_example
      assert_equal 0, solve(1)
      assert_equal 3, solve(12)
      assert_equal 2, solve(23)
      assert_equal 31, solve(1024)
    end
  end
end
