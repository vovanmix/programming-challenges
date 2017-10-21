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

end

def balanced_bfs?(root)
  max_level = -1
  min_level = 2**32 / 2 - 1
  queue = []
  queue.push([root, 0])
  while queue.size > 0
    node, level = queue.shift

    if node.left.nil? && node.right.nil?
      min_level = [min_level, level].min
      max_level = [max_level, level].max
    else
      unless node.left.nil?
        queue.push([node.left, level + 1])
      end

      unless node.right.nil?
        queue.push([node.right, level + 1])
      end
    end
  end

  max_level - min_level < 2
end

def balanced_dfs?(root)
  max_level = -1
  min_level = 2**32 / 2 - 1
  stack = []
  stack.push([root, 0])
  while stack.size > 0
    node, level = stack.pop

    if node.left.nil? && node.right.nil?
      min_level = [min_level, level].min
      max_level = [max_level, level].max

      return false if max_level - min_level >= 2
    else
      unless node.right.nil?
        stack.push([node.right, level + 1])
      end

      unless node.left.nil?
        stack.push([node.left, level + 1])
      end
    end
  end

  max_level - min_level < 2
end

t = BinaryTreeNode.new(1)
t2 = t.insert_left(2)
t3 = t.insert_right(3)
t4 = t2.insert_left(4)
t5 = t4.insert_left(5)
t6 = t2.insert_right(6)

puts balanced_bfs?(t).to_s
puts balanced_dfs?(t).to_s
