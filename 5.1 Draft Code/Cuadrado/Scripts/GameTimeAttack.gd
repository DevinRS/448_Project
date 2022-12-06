extends Node2D

#write to filename
func write(fileName,content):
	var file = File.new()
	file.open("user://"+fileName, File.WRITE)
	file.store_string(content)
	file.close()

#return content of filename
func read(fileName):
	var file = File.new()
	file.open("user://"+fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

# Customizable level data
export (int) var grid_width = 5
export (int) var grid_height = 5
export (int) var x_start = 460
export (int) var y_start = 170
export (int) var x_off = 90
export (int) var y_off = 95
export (int) var difficulty = int(read("DIFF.cfg"))

# Loading tiles to be used
var tiles = [
	preload("res://Scenes/BlankTile.tscn"),
	preload("res://Scenes/TileTopRight.tscn"),
	preload("res://Scenes/TileTopLeft.tscn"),
	preload("res://Scenes/TileBottomRight.tscn"),
	preload("res://Scenes/TileBottomLeft.tscn"),
	preload("res://Scenes/TileHorizontal.tscn"),
	preload("res://Scenes/TileVertical.tscn")
]


# Loading background
var bg = preload("res://Scenes/bg.tscn")

# Loading point counter
var counter = preload("res://Scenes/points.tscn")

# Loading timer
var timer = preload("res://Scenes/TIme.tscn")

# Alert
var alert = preload("res://Scenes/Alert.tscn")

# Lose Screen
var lose = preload("res://Scenes/LoseScreen.tscn")


# Random Number Generator
var random = RandomNumberGenerator.new()

# Initial grid
var level_grid = [
	[0, 1, 1, 1, 1],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6],
	[2, 3, 4, 5, 6]
]

# Coordinate for blank box
var blankboxposition
var points = 0
var goal = '1A'
var progress = 0
var state = 0

func _ready():
	var bgnode = bg.instance()
	add_child(bgnode)
	bgnode.position = Vector2(0,0)
	bgnode.z_index = 0
	
	var timernode = timer.instance()
	add_child(timernode)
	timernode.position = Vector2(910, 590)
	timernode.z_index = 1
	timernode.setdifficulty(difficulty)
	
	MusicController.playMusic("res://Sound/musicGame.mp3")
	
	generateGoal()
	rearrange()
	draw_level()
	
	
# Check for input every frame
func _process(delta):
	if(state == 0):
		check_input()
		checkTimer()
	
# Convert grid coordinates to pixel values
func grid_to_pixel(x, y):
	return Vector2(x * x_off + x_start, y * y_off + y_start)	

# Draw the level as pixels
func draw_level():
	delete_level()
	
	var counternode = counter.instance()
	add_child(counternode)
	counternode.position = Vector2(0,0)
	counternode.updatePointsAndGoal(points, goal)
	counternode.z_index = 1
	
	
	for i in range(grid_width):
		for j in range(grid_height):
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
	for n in range (2,get_node(".").get_child_count()):
		var removedNode = self.get_child(2)
		get_node(".").remove_child(removedNode)
		removedNode.queue_free()
		
# Function for checking input	
func check_input():
	# Calculate the direction the player is trying to go
	var dir = Vector2(0, 0)
	if (Input.is_action_just_pressed("ui_right")):
		dir = Vector2(-1, 0)
	elif (Input.is_action_just_pressed("ui_left")):
		dir = Vector2(1, 0)
	elif (Input.is_action_just_pressed("ui_up")):
		dir = Vector2(0, 1)
	elif (Input.is_action_just_pressed("ui_down")):
		dir = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_accept")):
		var win = checkWinCondition(goal[0], goal[1])
		if(win):
			SoundController.playSound("res://Sound/correct.mp3")
			points += 1
			generateGoal()
			resetTimer()
			rearrange()
			draw_level()
		else:
			SoundController.playSound("res://Sound/wrong.mp3")
			var alertnode = alert.instance()
			add_child(alertnode)
			alertnode.z_index = 3
		
	# Move the player to the new position
	if (dir != Vector2(0, 0)):
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
		
	# Set direction back to nothing
	dir = Vector2(0, 0)
	
	
# Function to generate goal
func generateGoal():
	random.randomize()
	var number = random.randi_range(1,6)
	random.randomize()
	var letter = random.randi_range(1,5)
	match letter:
		1: 
			letter = 'A'
		2:
			letter = 'B'
		3:
			letter = 'C'
		4:
			letter = 'D'
		5:
			letter = 'E'
	goal = str(number) + letter	

# Function to check win condition
func checkWinCondition(goalNumber, goalLetter):
	
	#initialize variable coordinates for runner
	var checkX = 0
	var checkY = 0
	
	#initailize goal coorindate
	var goalX
	var goalY
	
	#initialize variables used for checking
	var checkDir = 'D'
	var endState = false
	
	#set starting coordinates
	if (goalLetter == 'A'):
		checkX = 0
	elif (goalLetter == 'B'):
		checkX = 1
	elif (goalLetter == 'C'):
		checkX = 2
	elif (goalLetter == 'D'):
		checkX = 3
	elif (goalLetter == 'E'):
		checkX = 4
		
	#set goal coordinates
	if (goalNumber == '1'):
		goalX = -1
		goalY = 1
	elif (goalNumber == '2'):
		goalX = -1
		goalY = 3
	elif (goalNumber == '3'):
		goalX = 1
		goalY = 5
	elif (goalNumber == '4'):
		goalX = 3
		goalY = 5
	elif (goalNumber == '5'):
		goalX = 5
		goalY = 3
	elif (goalNumber == '6'):
		goalX = 5
		goalY = 1
	
	#run through path starting from letter to end of path
	while (true):
		if (checkDir == 'D' and checkY != 5):
			if (level_grid[checkX][checkY] == 1):
				checkDir = 'R'
				checkX += 1
			elif (level_grid[checkX][checkY] == 2):
				checkDir = 'L'
				checkX -= 1
			elif (level_grid[checkX][checkY] == 6):
				checkDir = 'D'
				checkY += 1
			else:
				break
		elif (checkDir == 'R' and checkX != 5):
			if (level_grid[checkX][checkY] == 2):
				checkDir = 'U'
				checkY -= 1
			elif (level_grid[checkX][checkY] == 4):
				checkDir = 'D'
				checkY += 1
			elif (level_grid[checkX][checkY] == 5):
				checkDir = 'R'
				checkX += 1
			else:
				break
		elif (checkDir == 'L' and checkX != -1):
			if (level_grid[checkX][checkY] == 1):
				checkDir = 'U'
				checkY -= 1
			elif (level_grid[checkX][checkY] == 3):
				checkDir = 'D'
				checkY += 1
			elif (level_grid[checkX][checkY] == 5):
				checkDir = 'L'
				checkX -= 1
			else:
				break
		elif (checkDir == 'U' and checkY != -1):
			if (level_grid[checkX][checkY] == 3):
				checkDir = 'R'
				checkX += 1
			elif (level_grid[checkX][checkY] == 4):
				checkDir = 'L'
				checkX -= 1
			elif (level_grid[checkX][checkY] == 6):
				checkDir = 'U'
				checkY -= 1
			else:
				break
		else:
			break
	
	#set endState true if goal is reached
	if (checkX == goalX):
		if (checkY == goalY):
			endState = true
	
	#return endState which is if win condition is met
	return endState
	
# Function for generating new board
func switch():
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
	
func rearrange():
	for i in range(1000):
		switch()
		
# Function to reset timer
func resetTimer():
	progress = 0
	var node = get_node(".").get_child(1)
	node.setprogressvalue(0)
	
func checkTimer():
	var node = get_node(".").get_child(1)
	if(node.getprogressvalue() == 100):
		var losenode = lose.instance()
		add_child(losenode)
		losenode.position = Vector2(0,0)
		losenode.z_index = 4
		state = 1
