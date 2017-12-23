def is_valid?(passphrase)
  words = passphrase.split(/\s/)
  words.uniq.size == words.size
end

def solve(arg)
  arg.count {|passphrase| is_valid? passphrase }
end

input = File.readlines("input")
p solve(input)

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal true, is_valid?("aa bb cc dd ee")
      assert_equal false, is_valid?("aa bb cc dd aa")
      assert_equal true, is_valid?("aa bb cc dd aaa")
    end
  end
end
