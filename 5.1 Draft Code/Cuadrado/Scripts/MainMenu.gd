extends Control

func write(fileName,content):
	var file = File.new()
	file.open("user://"+fileName, File.WRITE)
	file.store_string(content)
	file.close()
	
func read(fileName):
	var file = File.new()
	file.open("user://"+fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _ready():
	var file = File.new()
	if !(file.file_exists("user://SFX.cfg")):
		write("SFX.cfg","on")
	if !(file.file_exists("user://BGM.cfg")):
		write("BGM.cfg","on")
	if !(file.file_exists("user://DIFF.cfg")):
		write("DIFF.cfg","2")
	file.close()
	
	MusicController.playMusic("res://Sound/musicMainMenu.mp3")


func _on_SettingsButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/Settings.tscn")


func _on_NewGameButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/GameTimeAttack1.tscn")
	

func _on_AIButton_pressed():
	SoundController.playSound("res://Sound/click.mp3")
	get_tree().change_scene("res://Scenes/GameVersus.tscn")
	
