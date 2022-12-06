extends Sprite

# Function that controls the fail effect
func _fail(n=1):
	visible = true
	
	var t = Timer.new()
	t.set_wait_time(n)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()

	visible = false
	
