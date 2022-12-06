extends Node2D

# Define states
enum State {
	Easy,
	Hard
}

# initialize current state as easy
var current_state = State.Easy

# function that changes the state of the difficulty
func _change_state(new_state: int) -> void:
	var current_state = new_state
	match current_state:
		State.Easy:
			$TextureProgress.max_value = 90
		State.Hard:
			$TextureProgress.max_value = 30

# function that increments the value of the timer
func _on_Timer_timeout():
	$TextureProgress.value += 0.1
	

# Function that returns if timer is at its end
func _is_Full() -> bool:
	return ($TextureProgress.value == $TextureProgress.max_value)

# Function that resets the timer
func _reset_timer():
	$TextureProgress.value = 0
	
# Function to stop the timer
func _stop_timer():
	$Timer.stop()
	
# Function to start the timer
func _start_timer():
	$Timer.start()
