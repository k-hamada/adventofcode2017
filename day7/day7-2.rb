require "set"

class Program < Struct.new(:name, :weight, :above)
  def initialize(input)
    m = input.match(/(?<name>\w+) \((?<weight>\d+)\)(?: -> (?<above>.+))?/)
    super(m[:name], m[:weight].to_i, m[:above]&.split(/, /) || [])
  end

  def has_above?
    !above.empty?
  end

  def above_elements(programs)
    above.map {|e| programs[e] }
  end

  def all_weight(programs)
    return weight unless has_above?
    @all_weight ||= weight + above.sum {|name| programs[name].all_weight(programs) }
  end

  def weight_group(programs)
    @aboves ||= above.map {|e| programs[e] }
    @weight_group ||= @aboves.group_by {|e| e.all_weight(programs) }
  end

  def unbalance_programs(programs)
    group = weight_group(programs)
    group.size != 1 ? group.find {|k, v| v.size == 1 }[1] : []
  end

  def balance_weight(programs)
    group = weight_group(programs)
    group.find {|k, v| v.size != 1 }[0]
  end
end

def solve(programs)
  fixed_names = Set.new
  candidate, fixed = programs.values.partition(&:has_above?)
  fixed_names.merge fixed.map(&:name)
  until candidate.size == 1
    fixed, candidate = candidate.partition {|prog| prog.above.all? {|name| fixed_names.include? name } }
    fixed_names.merge fixed.map(&:name)
  end
  candidate.first[:name]
end

input = File.readlines("input")
@programs = input.map {|line| Program.new line }.map {|e| [e.name, e] }.to_h
queue = [[@programs[solve(@programs)], 0]]
until queue.empty?
  program, sibling_weight = *queue.shift
  unbalance_programs = program.unbalance_programs(@programs)
  unless unbalance_programs.empty?
    w = program.balance_weight(@programs)
    queue.push(*unbalance_programs.map {|e| [e, w] })
  else
    puts program.weight + (sibling_weight - program.all_weight(@programs))
  end
end
