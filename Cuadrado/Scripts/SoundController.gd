extends Node


#write to filename
func write(fileName,content):
	var file = File.new()
	file.open("user://"+fileName, File.WRITE)
	file.store_string(content)
	file.close()

#return content of filename
func read(fileName):
	var file = File.new()
	file.open("user://"+fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func playSound(fileLocation):
	if (read("SFX.cfg") == "on"):
		$Sound.stream = load(fileLocation)
		$Sound.play()

func stopSound():
	$Sound.stop()
