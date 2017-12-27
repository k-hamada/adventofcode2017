step = Fiber.new do
  n = 1
  Fiber.yield(n)
  loop do
    Fiber.yield(n)
    Fiber.yield(n)
    n += 1
  end
end

move = Fiber.new do
  Fiber.yield([ 0,  0])
  loop do
    Fiber.yield([ 1,  0])
    Fiber.yield([ 0,  1])
    Fiber.yield([-1,  0])
    Fiber.yield([ 0, -1])
  end
end

def wrap(x, y)
  [
    [x + 1, y + 0],
    [x + 1, y + 1],
    [x + 0, y + 1],
    [x - 1, y + 1],
    [x - 1, y + 0],
    [x - 1, y - 1],
    [x + 0, y - 1],
    [x + 1, y - 1],
  ]
end

def sum_wrap(table, wrap_points)
  return 1 if table.empty?
  wrap_points.sum {|x, y| table.dig(x, y) || 0 }
end

table = {}
x, y, n = 0, 0, 0
limit = 368078
while n < limit
  move_x, move_y = move.resume
  step.resume.times do
    x, y = x + move_x, y + move_y
    n = sum_wrap(table, wrap(x, y))
    table[x] ||= {}
    table[x][y] = n
  end
end
puts n
