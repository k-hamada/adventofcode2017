def ignore(text)
  text.gsub(/!./, "")
end

def garbage_count(text)
  text.scan(/<.*?>/).map {|e| e.size - 2 }.sum
end

def solve(arg)
  garbage_count(ignore(arg))
end

input = File.readlines("input")
puts solve(input.first)

__END__

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 0, solve("{}")
      assert_equal 17, solve("<random characters>")
      assert_equal 3, solve("<<<<>")
      assert_equal 2, solve("<{!>}>")
      assert_equal 0, solve("<!!>")
      assert_equal 0, solve("<!!!>>")
      assert_equal 10, solve('<{o"i!a,<{i<a>')
    end
  end
end
