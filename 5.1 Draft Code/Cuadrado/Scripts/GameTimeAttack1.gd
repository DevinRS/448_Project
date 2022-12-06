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
	
	# Add the Counter
	var counternode = counter.instance()
	add_child(counternode)
	counternode.position = Vector2(0,0)
	counternode.updatePointsAndGoal(points, goal)
	counternode.z_index = 1
	
	
# Check for input every frame
func _process(delta):
	if(state == 0):
		check_input()
		checkTimer()
		
# Function for checking input	
func check_input():
	if (Input.is_action_just_pressed("ui_right")):
		$Board.moveRight()
	elif (Input.is_action_just_pressed("ui_left")):
		$Board.moveLeft()
	elif (Input.is_action_just_pressed("ui_up")):
		$Board.moveUp()
	elif (Input.is_action_just_pressed("ui_down")):
		$Board.moveDown()
	elif (Input.is_action_just_pressed("ui_accept")):
		var win = $Board.checkWinCondition(goal[0], goal[1])
		if(win):
			SoundController.playSound("res://Sound/correct.mp3")
			points += 1
			$Board.rearrange()
			generateGoal()
			updateCounter()
			resetTimer()
		else:
			SoundController.playSound("res://Sound/wrong.mp3")
			var alertnode = alert.instance()
			add_child(alertnode)
			alertnode.z_index = 3
	
	
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

# Function to update counter
func updateCounter():
	var counternode = self.get_child(3)
	self.remove_child(counternode)
	counternode.queue_free()
	
	counternode = counter.instance()
	add_child(counternode)
	counternode.position = Vector2(0,0)
	counternode.updatePointsAndGoal(points, goal)
	counternode.z_index = 1

# Function to reset timer
func resetTimer():
	progress = 0
	var node = get_node(".").get_child(2)
	node.setprogressvalue(0)
	
func checkTimer():
	var node = get_node(".").get_child(2)
	if(node.getprogressvalue() == 100):
		var losenode = lose.instance()
		add_child(losenode)
		losenode.position = Vector2(0,0)
		losenode.z_index = 4
		state = 1
