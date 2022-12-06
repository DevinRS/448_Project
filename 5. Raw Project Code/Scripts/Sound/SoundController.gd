extends Node

# Play music
func playMusic(fileLocation):
	if (Global.read("BGM") == "1" and ($Music.stream != load(fileLocation) or !($Music.playing))):
		$Music.stream = load(fileLocation)
		$Music.play()

# Change music volume
func volumeMusic(vol):
	$Music.volume_db = vol

# Stop music
func stopMusic():
	$Music.stop()

# Play a sound and delete the leftover audio stream
func playSound(fileLocation):
	if (Global.read("SFX") == "1"):
		var sound = AudioStreamPlayer.new()
		add_child(sound)
		sound.stream = load(fileLocation)
		sound.play()
		yield(sound, "finished")
		sound.queue_free()
