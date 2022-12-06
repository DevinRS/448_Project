extends Node2D

export (int) var x_start = 45
export (int) var y_start = 170
export (int) var x_off = 90
export (int) var y_off = 90

var random = RandomNumberGenerator.new()

var tiles = [
	preload("res://Scenes/BlankTile.tscn"),
	preload("res://Scenes/TileTopRight.tscn"),
	preload("res://Scenes/TileTopLeft.tscn"),
	preload("res://Scenes/TileBottomRight.tscn"),
	preload("res://Scenes/TileBottomLeft.tscn"),
	preload("res://Scenes/TileHorizontal.tscn"),
	preload("res://Scenes/TileVertical.tscn")
]

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var blankboxposition
var freeze = 0
#
#func _process(delta):
#	if(state == 0):
#		check_input()
#	check_input()
		
		

# Function that puts the tiles on the grid
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)	

# Function that draws the level grid
func draw_level():
	delete_level()
	
	for i in range(level_grid.size()):
		for j in range(level_grid[0].size()):
			if (level_grid[i][j] == 0):
				var tile = tiles[0].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
				blankboxposition = Vector2(i, j)
			elif (level_grid[i][j] == 1):
				var tile = tiles[1].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
			elif (level_grid[i][j] == 2):
				var tile = tiles[2].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
			elif (level_grid[i][j] == 3):
				var tile = tiles[3].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
			elif (level_grid[i][j] == 4):
				var tile = tiles[4].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
			elif (level_grid[i][j] == 5):
				var tile = tiles[5].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
			elif (level_grid[i][j] == 6):
				var tile = tiles[6].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])
				tile.z_index = 2
	
# Function to reset the board
func delete_level():
#	for n in get_node(".").get_children():
#		if(n != get_node(".").get_child(0) && n != get_node(".").get_child(1) && n != get_node(".").get_child(2)):
#			get_node(".").remove_child(n)
#			n.queue_free()
	for n in range (0,get_node(".").get_child_count()):
		var removedNode = self.get_child(0)
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
		var tNode = self.get_child(self.get_child_count()-1)
		self.remove_child(tNode)
		tNode.queue_free()
		# Board unfreezes
		freeze = 0

# Function that returns if board is frozen
func isFrozen():
	return (freeze == 1)

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
