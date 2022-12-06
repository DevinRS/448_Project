extends Node2D

func _ready():
	SoundController.volumeMusic(-10)
	SoundController.playMusic("res://Sound/musicMainMenu.mp3")

# Clicking on newgame will start the singleplayer gamemode
func _on_button_newgame_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Game/NewGame.tscn")

# Clicking on pvp will start the 1 versus 1 gamemode
func _on_button_pvp_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Game/GameVersus.tscn")

# Clicking settings will present settings menu
func _on_button_settings_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Settings.tscn")

# Clicking quit exits the program
func _on_button_quit_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().quit()
