extends Node2D

var difficulty = 1

func _on_Timer_timeout():
	
	match(difficulty):
		1:
			$TextureProgress.value += 0.1
		2:
			$TextureProgress.value += 0.3
		3: 
			$TextureProgress.value += 0.6
	
	pass # Replace with function body.
	
func getprogressvalue():
	var progress = $TextureProgress.value
	return progress
	
func setprogressvalue(val):
	$TextureProgress.value = val
	
func setdifficulty(val):
	difficulty = val
