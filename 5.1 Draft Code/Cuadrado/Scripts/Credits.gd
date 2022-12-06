extends Control



func _on_BackButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Settings.tscn")
