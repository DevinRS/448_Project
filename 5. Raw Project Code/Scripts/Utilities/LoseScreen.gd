extends Node2D


# Clicking on play again will restart the current game
func _on_playagain_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().reload_current_scene()

# Clicking on exit game exits to the main menu
func _on_exitgame_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
