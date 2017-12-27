def solve(arg)
  numbers = arg.chars.map(&:to_i)
  helf_size = arg.size / 2
  numbers.take(helf_size).map.with_index.select {|e, i| e == numbers[i + helf_size] }.sum {|e, i| e } * 2
end

input = File.read("input").chomp
puts solve(input)

__END__
if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 6, solve("1212")
      assert_equal 0, solve("1221")
      assert_equal 4, solve("123425")
      assert_equal 12, solve("123123")
      assert_equal 4, solve("12131415")
    end
  end
end
