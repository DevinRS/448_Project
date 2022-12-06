extends Node2D

# Pixel distance from one point of tile to the next
export (int) var x_off = 90
export (int) var y_off = 90

# Create random number generator
var random = RandomNumberGenerator.new()

# Load images onto tiles
var tiles = [
	preload("res://Sprites/Tiles/Blank.png"),
	preload("res://Sprites/Tiles/tile_topright.png"),
	preload("res://Sprites/Tiles/tile_topleft.png"),
	preload("res://Sprites/Tiles/tile_bottomright.png"),
	preload("res://Sprites/Tiles/tile_bottomleft.png"),
	preload("res://Sprites/Tiles/tile_horizontal.png"),
	preload("res://Sprites/Tiles/tile_vertical.png"),
]

# Load tile
var tile = preload("res://Scenes/Utilities/Tile.tscn")

# Initial grid
var level_grid = [
	[0, 1, 1, 1, 1],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	rearrange()
	draw_level()


var blankboxposition
var freeze = 0

# Function that puts the tiles on the grid
func grid_to_pixel(x, y):
	return Vector2(x * x_off, y * y_off)	

# Function that draws the level grid
func draw_level():
	delete_level()
	for i in range(level_grid.size()):
		for j in range(level_grid[0].size()):
			if (level_grid[i][j] == 0):
				var tileNode = tile.instance()
				add_child(tileNode)
				var pos = grid_to_pixel(i, j)
				tileNode.position = Vector2(pos[0], pos[1])
				blankboxposition = Vector2(i, j)
			else:
				var tileNode = tile.instance()
				add_child(tileNode)
				var pos = grid_to_pixel(i, j)
				tileNode.position = Vector2(pos[0], pos[1])
				tileNode.get_child(0).texture = tiles[level_grid[i][j]]
	
# Function to reset the board
func delete_level():
	for n in range (1,get_node(".").get_child_count()):
		var removedNode = self.get_child(1)
		get_node(".").remove_child(removedNode)
		removedNode.queue_free()

# Function that moves tiles
func move(dir):
	if (freeze == 0 && dir != Vector2(0, 0)):
		var target = Vector2(blankboxposition[0] + dir[0], blankboxposition[1] + dir[1])
		if(target[0] == -1 or target[0] == 5 or target[1] == -1 or target[1] == 5):
			return
		else:
			SoundController.playSound("res://Sound/slide.mp3")
			var target_value = level_grid[target[0]][target[1]]
			level_grid[target[0]][target[1]] = 0
			level_grid[blankboxposition[0]][blankboxposition[1]] = target_value
			blankboxposition[0] = target[0]
			blankboxposition[1] = target[1]
			draw_level()

# Functions that call a function to move
func moveRight():
	move(Vector2(-1, 0))
func moveLeft():
	move(Vector2(1, 0))
func moveUp():
	move(Vector2(0, 1))
func moveDown():
	move(Vector2(0, -1))

# Function that freezes the board
func freeze(n=0):
	# Board frozen
	freeze = 1
	if (n > 0):
		# n second timer
		var t = Timer.new()
		t.set_wait_time(n)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		# Board unfreezes
		freeze = 0

# Function that returns if board is frozen
func isFrozen():
	return (freeze == 1)

# Function that rearranges 
func rearrange():
	for i in range(1000):
		random.randomize()
		var x1 = random.randi_range(0, 4)
		random.randomize()
		var y1 = random.randi_range(0, 4)
		random.randomize()
		var x2 = random.randi_range(0, 4)
		random.randomize()
		var y2 = random.randi_range(0, 4)

		var target = level_grid[x2][y2]

		level_grid[x2][y2] = level_grid[x1][y1]
		level_grid[x1][y1] = target
	draw_level()

# Update Chicken Nest Goal
func goalUpdate(goal):
	$ChickenNest._change_goal(goal)

# Function to check if a win condition has been met
func checkWinCondition(goalNumber, goalLetter):
	
	# Initialize variable coordinates for runner
	var checkX = 0
	var checkY = 0
	
	# Initailize goal coorindate
	var goalX
	var goalY
	
	# Initialize variables used for checking
	var checkDir = 'D'
	var endState = false
	
	# Set starting coordinates
	match goalLetter:
		'A':
			checkX = 0
		'B':
			checkX = 1
		'C':
			checkX = 2
		'D':
			checkX = 3
		'E':
			checkX = 4
		
	# Set goal coordinates
	match goalNumber:
		'1':
			goalX = -1
			goalY = 1
		'2':
			goalX = -1
			goalY = 3
		'3':
			goalX = 1
			goalY = 5
		'4':
			goalX = 3
			goalY = 5
		'5':
			goalX = 5
			goalY = 3
		'6':
			goalX = 5
			goalY = 1
	
	# Run through path starting from letter to end of path
	while (true):
		# Went down from last tile
		if (checkDir == 'D' and checkY != 5):
			# Check current tile type and move the runner coordinate
			match level_grid[checkX][checkY]:
				1:
					checkDir = 'R'
					checkX += 1
				2:
					checkDir = 'L'
					checkX -= 1
				6:
					checkDir = 'D'
					checkY += 1
				_:
					break # Dead end hit
		# Came right from last tile
		elif (checkDir == 'R' and checkX != 5):
			# Check current tile type and move the runner coordinate
			match level_grid[checkX][checkY]:
				2:
					checkDir = 'U'
					checkY -= 1
				4:
					checkDir = 'D'
					checkY += 1
				5:
					checkDir = 'R'
					checkX += 1
				_:
					break # Dead end hit
		# Came left from last tile
		elif (checkDir == 'L' and checkX != -1):
			# Check current tile type and move the runner coordinate
			match level_grid[checkX][checkY]:
				1: 
					checkDir = 'U'
					checkY -= 1
				3:
					checkDir = 'D'
					checkY += 1
				5: 
					checkDir = 'L'
					checkX -= 1
				_:
					break # Dead end hit
		# Came up from last tile
		elif (checkDir == 'U' and checkY != -1):
			# Check current tile type and move the runner coordinate
			match level_grid[checkX][checkY]:
				3:
					checkDir = 'R'
					checkX += 1
				4:
					checkDir = 'L'
					checkX -= 1
				6:
					checkDir = 'U'
					checkY -= 1
				_:
					break # Dead end hit
		else:
			break # Dead end hit
	
	#set endState true if goal is reached
	if (checkX == goalX):
		if (checkY == goalY):
			endState = true
	
	#return endState which is if win condition is met
	return endState
	
