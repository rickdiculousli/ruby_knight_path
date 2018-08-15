class Node
  attr_accessor :val, :children, :parents
  def initialize(val)
    @val = val
    @children = []
    @parents = []
  end

  def ==(o)
    self.class == o.class && self.val == o.val
  end
end

def paths(key)
  array = []
  array << [key[0]+2, key[1]+1]
  array << [key[0]+2, key[1]-1]
  array << [key[0]-2, key[1]+1]
  array << [key[0]-2, key[1]-1]
  array << [key[0]+1, key[1]+2]
  array << [key[0]-1, key[1]+2]
  array << [key[0]+1, key[1]-2]
  array << [key[0]-1, key[1]-2]
  array
end

def create_board
  nodes = {}
  (0..7).each do |x|
    (0..7).each do |y|
      nodes[[x,y]] = Node.new([x,y])
    end
  end
  nodes.each do |key,val|
    paths(key).each do |o_key|
      val.children << nodes[o_key] unless nodes[o_key].nil?
    end
  end
  nodes
end

def knight_path(start,goal,nodes)
  root = nodes[start]
  dest = nodes[goal]
  Kernel.puts "  start at: #{root.val}"
  Kernel.puts "  end at: #{dest.val}"
  known_nodes = []
  queue = [root]

  until queue.empty?
    test = queue.shift
    if test == dest
      test.parents << test
      return test.parents
    else
      avail_paths = test.children - known_nodes
      avail_paths.each do |n|
        n.parents.concat(test.parents)
        n.parents << test
      end
      queue.concat(avail_paths)
      known_nodes.concat(avail_paths)
    end
  end
  nil
end
puts "begin app!"
board = create_board
puts "created board!"
puts "begin pathfinding!"
path = knight_path([0,0],[5,6], board)
puts "path found!"
puts "Path route: #{path.map{|x| x.val}}"
sleep 2
puts "Now test your own!"
loop do
  puts "input starting coordinates: '0-7,0-7'"
  s = gets.chomp.split(",")
  s = [s[0].to_i,s[1].to_i]
  puts "input destination coordinates: '0-7,0-7'"
  d = gets.chomp.split(",")
  d = [d[0].to_i,d[1].to_i]
  b = create_board
  path = knight_path(s,d, b)
  puts "Path route: #{path.map{|x| x.val}}"
  4.times do
    sleep 1
    print "."
  end
  system "clr" or system "clear"
end


