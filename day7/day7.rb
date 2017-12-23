require "set"

class Program < Struct.new(:name, :weight, :above)
  def initialize(input)
    m = input.match(/(?<name>\w+) \((?<weight>\d+)\)(?: -> (?<above>.+))?/)
    super(m[:name], m[:weight].to_i, m[:above]&.split(/, /) || [])
  end

  def has_above?
    above.empty?
  end
end

def solve(arg)
  fixed_names = Set.new
  programs = arg.map {|line| Program.new line }
  fixed, candidate = programs.partition(&:has_above?)
  fixed_names.merge fixed.map(&:name)
  until candidate.size == 1
    fixed, candidate = candidate.partition {|prog| prog.above.all? {|name| fixed_names.include? name } }
    fixed_names.merge fixed.map(&:name)
  end
  candidate.first[:name]
end

input = File.readlines("input")
puts solve(input)
