extends Node2D

# Clicking on the back button takes user back to main menu
func _on_button_back_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

# Clicking on Credits takes user to the credit scene
func _on_TextureButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Credits.tscn")
