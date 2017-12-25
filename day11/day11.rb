# https://www.redblobgames.com/grids/hexagons/

Hex = Struct.new(:x, :y, :z) do
  def add(hex)
    Hex.new(x + hex.x, y + hex.y, z + hex.z)
  end

  def distance(hex)
    ((x - hex.x).abs + (y - hex.y).abs + (z - hex.z).abs) / 2
  end

  def move(*operators)
    operators.reduce(self) {|a, e| a.add(Directions[e]) }
  end
end

Directions = {
  "n"  => Hex.new(1, -1, 0),
  "ne" => Hex.new(1, 0, -1),
  "se" => Hex.new(0, 1, -1),
  "s"  => Hex.new(-1, 1, 0),
  "sw" => Hex.new(-1, 0, 1),
  "nw" => Hex.new(0, -1, 1),
}

def solve(*steps)
  zero = Hex.new(0, 0, 0)
  zero.distance(zero.move(*steps))
end

input = File.read("input")
puts solve(*input.chomp.split(/,/))

__END__

if $0 == __FILE__
  require 'test/unit'

  class TestExample < Test::Unit::TestCase
    def test_example
      assert_equal 3, solve("nw", "nw", "nw")
      assert_equal 0, solve("ne", "ne", "sw", "sw")
      assert_equal 2, solve("ne", "ne", "s", "s")
      assert_equal 3, solve("se", "sw", "se", "sw", "sw")
    end
  end
end
