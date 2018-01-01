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
  return 0 unless check_condition(instruction)

  case instruction[:op]
  when "inc"
    op = :+
  when "dec"
    op = :-
  end

  @register[instruction[:key]] = @register[instruction[:key]].send(op, instruction[:value].to_i)
end

def solve(arg)
  max_register = 0
  arg.each do |line|
     max_register = [max_register, register_to_modify(Instruction.new(line))].max
  end
  max_register
end

input = File.readlines("input")
puts solve(input)
