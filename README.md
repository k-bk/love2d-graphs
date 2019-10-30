# love2d-graphs
I am developing it to display algorithms in computational geometry.

## Running
To test this library run `make`. 
It will first download `love` executable.

To test the modules run `make test`

## Usage
```lua
graph = require "graph"

-- points organized as { x,y, x,y, x,y ... }
p1 = { 1,1, 2,5, 3,7, color = graph.c.blue }
p2 = { 6,8, 4.5,33, 1,-1, color = graph.c.red }
graph.graph { p1, p2, title = "Example points" }
```

## Features:

- scaling to window size
- chart title
- more to come...

![alt text][animation]

[animation]: show.gif "Showcase animation"
