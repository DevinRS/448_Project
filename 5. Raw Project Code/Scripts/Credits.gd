extends Node2D

# Clicking back goes back to settings
func _on_button_back_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")
