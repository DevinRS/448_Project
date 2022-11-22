extends Node2D

# Load random
var random = RandomNumberGenerator.new()
var x = 0
var readyP1 = 0
var readyP2 = 0
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundController.playMusic("res://Sound/musicGame.mp3")
	generateGoal()
	$BoardP1.goalUpdate(goal)
	$BoardP2.goalUpdate(goal)

# Variables keep track of player scores and the goal
var goal = "1A"
var tokens = ['A','B','C','D','E']

# Function that checks if the player got the point
func accept(board):
	match board:
		0:
			if($BoardP1.checkWinCondition(goal[0], goal[1])):
				SoundController.playSound("res://Sound/correct.mp3")
				$BoardP1/ChickenNest._delete_nest(goal[1])
				$BoardP2/ChickenNest._delete_nest(goal[1])
				$HealthP2._change_state($HealthP2._get_state()-1)
				if($HealthP2._get_state() == 0):
					lose()
				else:
					generateGoal()
					$BoardP1.goalUpdate(goal)
					$BoardP2.goalUpdate(goal)
			else:
				SoundController.playSound("res://Sound/wrong.mp3")
				# Player frozen
				$BoardP1.freeze(1)
				$Fail._failLeft()
		1:
			if($BoardP2.checkWinCondition(goal[0], goal[1])):
				SoundController.playSound("res://Sound/correct.mp3")
				$BoardP1/ChickenNest._delete_nest(goal[1])
				$BoardP2/ChickenNest._delete_nest(goal[1])
				$HealthP1._change_state($HealthP1._get_state()-1)
				if($HealthP1._get_state() == 0):
					lose()
				else:
					generateGoal()
					$BoardP1.goalUpdate(goal)
					$BoardP2.goalUpdate(goal)
			else:
				SoundController.playSound("res://Sound/wrong.mp3")
				# Player frozen
				$BoardP2.freeze(1)
				$Fail._failRight()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(readyP1 == 1 && readyP2 == 1 && state == 0):
		check_input()
		
func check_input():
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
	letter = tokens.pop_at(letter)
	goal = str(number) + str(letter)



func _on_ShuffleP1_pressed():
	if(!readyP1):
		$BoardP1.rearrange()


func _on_ShuffleP2_pressed():
	if(!readyP2):
		$BoardP2.rearrange()


func _on_ReadyP1_pressed():
	readyP1 = 1
	$ReadyP1.disabled = true
	
	
func _on_ReadyP2_pressed():
	readyP2 = 1
	$ReadyP2.disabled = true
	
func lose():
	state = 1
	$LoseScreen.visible = true
