extends Node2D

# Assign variables when nodes ready
onready var ChickenNest = get_node("ChickenNest")
onready var Points = get_node("Points")
onready var TimerNode = get_node("Timer")
onready var Fail = get_node("Fail")
onready var LoseScreen = get_node("LoseScreen")

# Random Number Generator
var random = RandomNumberGenerator.new()

# Read in dificulty from disk
var difficulty = int(Global.read("DIFF"))

# intiialize points as 0
var points = 0

# initialize goal as a string of nothing
var goal = ""

# initialize state as 0, meaning unfrozen
var state = 0

func _ready():
	# Start Music
	SoundController.playMusic("res://Sound/musicGame.mp3")
	
	# Initialize game and game properties
	generateGoal() 
	$Board.goalUpdate(goal)
	TimerNode._change_state(difficulty)

# Check for input every frame
func _process(delta):
	if(state == 0):
		check_input()
		if (TimerNode._is_Full()):
			lose()

		
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
			# Process for winning
			SoundController.playSound("res://Sound/correct.mp3")
			points += 1
			Points._update_point(points)
			$Board.rearrange()
			generateGoal()
			$Board.goalUpdate(goal)
			TimerNode._reset_timer()
		else:
			# Process for failure to win
			SoundController.playSound("res://Sound/wrong.mp3")
			Fail._fail()
	elif (Input.is_action_just_pressed("ui_escape")):
		pause()
	
	
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
	
# Function that handles losing
func lose():
	state = 1
	LoseScreen.visible = true
	
# Function that handles pausing
func pause():
	state = 1
	TimerNode._stop_timer()
	$PauseScreen.visible = true

# Function that handles unpausing
func unpause():
	state = 0
	TimerNode._start_timer()
	$PauseScreen.visible = false
