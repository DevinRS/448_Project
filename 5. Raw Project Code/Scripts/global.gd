extends Node

# Function to write to disk a filename and its content
func write(fileName,content):
	var file = File.new()
	file.open("user://"+fileName, File.WRITE)
	file.store_string(content)
	file.close()
	
# Function to read a filename from disk
func read(fileName):
	var file = File.new()
	file.open("user://"+fileName, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

# Makes sure tha there are files that exist on Disk to read from properly
func _ready():
	var file = File.new()
	if !(file.file_exists("user://SFX")):
		write("SFX","1")
	if !(file.file_exists("user://BGM")):
		write("BGM","1")
	if !(file.file_exists("user://DIFF")):
		write("DIFF","0")
	file.close()
