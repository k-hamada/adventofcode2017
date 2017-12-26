require "set"

Program = Struct.new(:id, :links) do
  def initialize(line)
    id, links = *line.split(" <-> ")
    link_ids = links.split(", ")
    super(id.to_i, link_ids.map(&:to_i))
  end
end

def parse(arg)
  arg.split(/\n/)
    .map {|line| Program.new(line.chomp) }
    .map {|prog| [prog.id, prog] }
    .to_h
end

def solve(arg, start_id)
  programs, queue, visited = parse(arg), [start_id], Set.new

  until queue.empty?
    current_id = queue.pop
    next if visited.include? current_id
    visited << current_id
    next_prog = programs[current_id]
    next_ids = next_prog.links
    queue.push *next_ids.to_set.subtract(visited).to_a
  end

  visited.size
end

input = File.read("input")
puts solve(input, 0)
