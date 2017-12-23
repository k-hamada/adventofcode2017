def solve(arg)
  arg.chars.tap{|x| x << x[0]}.each_cons(2).select {|a, b| a == b }.map {|a| a.first.to_i }.sum
end

input = File.read("input").chomp
puts solve(input)

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 3, solve("1122")
      assert_equal 4, solve("1111")
      assert_equal 0, solve("1234")
      assert_equal 9, solve("91212129")
    end
  end
end
