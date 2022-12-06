extends Control

onready var text = get_node("RichTextLabel")
var point = 0

func _update_point(new_point: int):
	point = new_point
	text.text = "points: " + str(point)
