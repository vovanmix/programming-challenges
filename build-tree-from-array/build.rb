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

t = build_tree([10, 4, 12, 3, 5, 11, 20, [nil] * 6, 19, 40, [nil] * 14, 30, nil, [nil] * 29, 35, nil, nil].flatten)
