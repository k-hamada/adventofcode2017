def is_valid?(passphrase)
  words = passphrase.split(/\s/)
  words.map {|word| word.chars.sort }.uniq.size == words.size
end

def solve(arg)
  arg.count {|passphrase| is_valid? passphrase }
end

input = File.readlines("input")
p solve(input)

__END__
if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal true, is_valid?("abcde fghij")
      assert_equal false, is_valid?("abcde xyz ecdab")
      assert_equal true, is_valid?("a ab abc abd abf abj")
      assert_equal true, is_valid?("iiii oiii ooii oooi oooo")
      assert_equal false, is_valid?("oiii ioii iioi iiio")
    end
  end
end
