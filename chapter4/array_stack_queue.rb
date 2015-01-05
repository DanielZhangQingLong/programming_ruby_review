# > It is important to know how to describe basic data structure and algrithms in one language.
# > Ruby gives very simple ways to describe stack and queue that using array.

stack = []

stack.push "red"
stack.push "green"
stack.push "blue"

# => ["red", "green", "blue"]

stack.pop

# => "blue"

stack.pop

# => "green"




queue = []

queue.push :red

queue.push :blue

queue.push :green

queue.shift

# => :red
