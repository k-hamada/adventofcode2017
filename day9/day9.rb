def ignore(text)
  text.gsub(/!./, "")
end

def garbage(text)
  text.gsub(/<>|<.+?>|,/, "")
end

def count(text)
  text.scan("{}").size
end

def solve(arg)
  score = []
  nest = 0
  text = garbage(ignore(arg))
  text.chars.each do |c|
    case c
    when "{"
      nest += 1
    when "}"
      score << nest
      nest -= 1
    end
  end
  score.sum
end

input = File.readlines("input")
puts solve(input.first)

__END__

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 1, solve("{}")
      assert_equal 6, solve("{{{}}}")
      assert_equal 5, solve("{{},{}}")
      assert_equal 16, solve("{{{},{},{{}}}}")
      assert_equal 1, solve("{<a>,<a>,<a>,<a>}")
      assert_equal 9, solve("{{<ab>},{<ab>},{<ab>},{<ab>}}")
      assert_equal 9, solve("{{<!!>},{<!!>},{<!!>},{<!!>}}")
      assert_equal 3, solve("{{<a!>},{<a!>},{<a!>},{<ab>}}")
    end
  end
end
