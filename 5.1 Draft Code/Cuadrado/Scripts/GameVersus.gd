extends Node2D

# Load random
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	generateGoal()
	$Score.text = "Score: " + str(scores)
	pass # Replace with function body.

# Variables keep track of player scores and the goal
var scores = [0,0]
var goal = "1A"
var tokens = ['A','B','C','D','E']

# Function that checks if the player got the point
func accept(board):
	if (self.get_child(board).checkWinCondition(goal[0],goal[1])):
		SoundController.playSound("res://Sound/correct.mp3")
		scores[board] += 1
		$Score.text = "Score: " + str(scores)
		$BoardP1.rearrange()
		$BoardP2.rearrange()
		generateGoal()
	elif (!self.get_child(board).isFrozen()):
		SoundController.playSound("res://Sound/wrong.mp3")
		# Player frozen
		self.get_child(board).freeze(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("p1_right")):
		$BoardP1.moveRight()
	elif (Input.is_action_just_pressed("p1_left")):
		$BoardP1.moveLeft()
	elif (Input.is_action_just_pressed("p1_up")):
		$BoardP1.moveUp()
	elif (Input.is_action_just_pressed("p1_down")):
		$BoardP1.moveDown()
	elif (Input.is_action_just_pressed("p2_right")):
		$BoardP2.moveRight()
	elif (Input.is_action_just_pressed("p2_left")):
		$BoardP2.moveLeft()
	elif (Input.is_action_just_pressed("p2_up")):
		$BoardP2.moveUp()
	elif (Input.is_action_just_pressed("p2_down")):
		$BoardP2.moveDown()
	elif (Input.is_action_just_pressed("p1_accept")):
		accept(0) #passes player 1's board
	elif (Input.is_action_just_pressed("p2_accept")):
		accept(1) #passes player 2's board

# Function to generate new goal
func generateGoal():
	random.randomize()
	var number = random.randi_range(1,6)
	random.randomize()
	var letter = random.randi_range(0,tokens.size()-1)
#	match letter:
#		1: 
#			letter = 'A'
#		2:
#			letter = 'B'
#		3:
#			letter = 'C'
#		4:
#			letter = 'D'
#		5:
#			letter = 'E'
	letter = tokens.pop_at(letter)
	goal = str(number) + str(letter)
	$Goal.text = "Goal: " + goal + "\n" + str(tokens)

