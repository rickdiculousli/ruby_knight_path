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
  Kernel.puts "  created nodes!"
  nodes.each do |key,val|
    paths(key).each do |o_key|
      val.children << nodes[o_key] unless nodes[o_key].nil?
    end
    Kernel.puts "  gave #{val.val}: #{val.children.map{|x| x.val}} children"
  end
  nodes
end

def knight_path(start,goal,nodes)
  root = nodes[start]
  dest = nodes[goal]
  known_nodes = []
  queue = [root]

  until queue.empty?
    test = queue.shift
    puts "#{queue.size}"
    if test == dest
      return test.parents
    else
      avail_paths = test.children - known_nodes
      avail_paths.each do |n|
        n.parents << test
      end
      queue.concat(avail_paths)
      known_nodes.concat(avail_paths)
    end
  end
end
puts "begin app!"
board = create_board
puts "created board!"
# pknight_path([0,0],[4,4], board)

