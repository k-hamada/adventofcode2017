@register = {}
@register.default = 0

class Instruction < Struct.new(:key, :op, :value, :_, :valueondition_key, :valueondition_op, :valueondition_value)
  def initialize(input)
    super(*input.split(/\s/))
  end
end

def check_condition(instruction)
  @register[instruction[:valueondition_key]]
    .send(instruction[:valueondition_op].to_sym, instruction[:valueondition_value].to_i)
end

def register_to_modify(instruction)
  return unless check_condition(instruction)

  case instruction[:op]
  when "inc"
    op = :+
  when "dec"
    op = :-
  end

  @register[instruction[:key]] = @register[instruction[:key]].send(op, instruction[:value].to_i)
end

def solve(arg)
  arg.each do |line|
    register_to_modify(Instruction.new(line))
  end
  @register.values.max
end

input = File.readlines("input")
puts solve(input)
