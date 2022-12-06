extends Node2D

var texture = [
	preload("res://Sprites/Utilities/button_difficulty/button_difficulty0hover.png"),
	preload("res://Sprites/Utilities/button_difficulty/button_difficulty0.png"),
	preload("res://Sprites/Utilities/button_difficulty/button_difficulty1hover.png"),
	preload("res://Sprites/Utilities/button_difficulty/button_difficulty1.png")
]


enum State{
	Easy,
	Hard
}

var current_state = int(Global.read("DIFF"))
onready var textureButton = get_node("TextureButton")

func _ready():
	_change_state(current_state)
	
func _change_state(new_state: int) -> void:
	current_state = new_state
	Global.write("DIFF",str(current_state))
	match current_state:
		State.Easy:
			textureButton.texture_normal = texture[1]
			textureButton.texture_hover = texture[0]
		State.Hard:
			textureButton.texture_normal = texture[3]
			textureButton.texture_hover = texture[2]


func _on_TextureButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	match current_state:
		State.Easy:
			_change_state(State.Hard)
		State.Hard:
			_change_state(State.Easy)
