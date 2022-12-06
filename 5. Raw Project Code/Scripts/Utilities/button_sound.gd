extends Node2D

var texture = [
	preload("res://Sprites/Utilities/button_sound/button_sound0hover.png"),
	preload("res://Sprites/Utilities/button_sound/button_sound0.png"),
	preload("res://Sprites/Utilities/button_sound/button_sound1hover.png"),
	preload("res://Sprites/Utilities/button_sound/button_sound1.png")
]


enum State{
	Off,
	On
}

var current_state = int(Global.read("SFX"))
onready var textureButton = get_node("TextureButton")

func _ready():
	_change_state(current_state)

func _change_state(new_state: int) -> void:
	current_state = new_state
	Global.write("SFX",str(current_state))
	match current_state:
		State.Off:
			textureButton.texture_normal = texture[1]
			textureButton.texture_hover = texture[0]
		State.On:
			textureButton.texture_normal = texture[3]
			textureButton.texture_hover = texture[2]


func _on_TextureButton_pressed():
	match current_state:
		State.Off:
			_change_state(State.On)
		State.On:
			_change_state(State.Off)
	SoundController.playSound("res://Sound/click.mp3")
