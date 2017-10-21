class BinaryTreeNode

  attr_accessor :value
  attr_reader :left, :right

  def initialize(value)
    @value = value
    @left  = nil
    @right = nil
  end

  def insert_left(value)
    @left = BinaryTreeNode.new(value)
    @left
  end

  def insert_right(value)
    @right = BinaryTreeNode.new(value)
    @right
  end

  def to_s
    @value
  end

end

def build_tree(array)
  root = BinaryTreeNode.new(array.shift)
  nodes_queue = [[root, :left], [root, :right]]

  until array.empty?
    element = array.shift
    parent, direction = nodes_queue.shift

    if element.nil?
      nodes_queue.push([nil, nil])
      nodes_queue.push([nil, nil])
      next
    end

    raise IndexError.new('incorrect node order in input') unless parent

    node = if direction == :left
             parent.insert_left(element)
           else
             parent.insert_right(element)
           end

    nodes_queue.push([node, :left])
    nodes_queue.push([node, :right])
  end

  root
end

################

## iterative approach

def second_largest(root)
  root = find_largest(root)
  return find_largest(root.left) if root.left
  root
end

def find_largest(root)
  while root
    return root unless root.right
    root = root.right
  end
end

## recursive approach

def largest_node(root)
  raise Error.new('No node!') unless root
  return largest_node(root.right) if root.right
  root
end

def second_largest_rec(root)
  largest = largest_node(root)
  return largest_node(largest.left) if largest.left
  largest
end

t = build_tree([10, 4, 12, 3, 5, 11, 20, [nil] * 6, 19, 40, [nil] * 14, 30, nil, [nil] * 29, 35, nil, nil].flatten)

puts second_largest(t).value
puts second_largest_rec(t).value
