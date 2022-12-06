extends Node2D

func _on_resume_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_parent().unpause()

func _on_exitgame_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
