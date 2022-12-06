extends Node2D

var texture = [
	preload("res://Sprites/Utilities/button_bgm/button_bgm0hover.png"),
	preload("res://Sprites/Utilities/button_bgm/button_bgm0.png"),
	preload("res://Sprites/Utilities/button_bgm/button_bgm1hover.png"),
	preload("res://Sprites/Utilities/button_bgm/button_bgm1.png")
]


enum State{
	Off,
	On
}

var current_state = int(Global.read("BGM"))
onready var textureButton = get_node("TextureButton")

func _ready():
	_change_state(current_state)
	
func _change_state(new_state: int) -> void:
	current_state = new_state
	Global.write("BGM",str(current_state))
	match current_state:
		State.Off:
			textureButton.texture_normal = texture[1]
			textureButton.texture_hover = texture[0]
			SoundController.stopMusic()
		State.On:
			textureButton.texture_normal = texture[3]
			textureButton.texture_hover = texture[2]
			SoundController.playMusic("res://Sound/musicMainMenu.mp3")


func _on_TextureButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	match current_state:
		State.Off:
			_change_state(State.On)
		State.On:
			_change_state(State.Off)
