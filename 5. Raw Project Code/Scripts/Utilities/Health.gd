extends Node2D

var texture = [
	preload("res://Sprites/Utilities/Health/health0.png"),
	preload("res://Sprites/Utilities/Health/health1.png"),
	preload("res://Sprites/Utilities/Health/health2.png"),
	preload("res://Sprites/Utilities/Health/health3.png")
]

enum State {
	Health0,
	Health1,
	Health2,
	Health3
}

var current_state = State.Health3

func _change_state(new_state: int) -> void:
	current_state = new_state
	match current_state:
		0:
			$TextureRect.texture = texture[0]
		1:
			$TextureRect.texture = texture[1]
		2:
			$TextureRect.texture = texture[2]
		3:
			$TextureRect.texture = texture[3]
			
			
func _get_state() -> int:
	return current_state
