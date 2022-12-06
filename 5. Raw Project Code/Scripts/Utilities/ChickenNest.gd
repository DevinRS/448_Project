extends Node2D


onready var chicken1 = get_node("chicken1")
onready var chicken2 = get_node("chicken2")
onready var chicken3 = get_node("chicken3")
onready var chicken4 = get_node("chicken4")
onready var chicken5 = get_node("chicken5")
onready var chicken6 = get_node("chicken6")

onready var nestA = get_node("nestA")
onready var nestB = get_node("nestB")
onready var nestC = get_node("nestC")
onready var nestD = get_node("nestD")
onready var nestE = get_node("nestE")

var opacityOff = 0.2

enum State {
	Default,
	Goal
}

var current_state = State.Default
var current_goal = "2D"

func _ready():
	_change_goal("2D")

func _change_state(new_state: int) -> void:
	var current_state = new_state
	match current_state:
		State.Default:
			chicken1.modulate.a = opacityOff
			chicken2.modulate.a = opacityOff
			chicken3.modulate.a = opacityOff
			chicken4.modulate.a = opacityOff
			chicken5.modulate.a = opacityOff
			chicken6.modulate.a = opacityOff
			nestA.modulate.a = opacityOff
			nestB.modulate.a = opacityOff
			nestC.modulate.a = opacityOff
			nestD.modulate.a = opacityOff
			nestE.modulate.a = opacityOff
		State.Goal:
			var chicken = current_goal[0]
			match chicken:
				"1":
					chicken = chicken1
				"2":
					chicken = chicken2
				"3":
					chicken = chicken3
				"4":
					chicken = chicken4
				"5":
					chicken = chicken5
				"6":
					chicken = chicken6
			var nest = current_goal[1]
			match nest:
				"A":
					nest = nestA
				"B":
					nest = nestB
				"C":
					nest = nestC
				"D":
					nest = nestD
				"E":
					nest = nestE
					
			chicken.modulate.a = 1
			nest.modulate.a = 1
					
			
			
func _change_goal(new_goal: String) -> void:
	_change_state(0)
	current_goal = new_goal
	_change_state(1)
	
func _delete_nest(nest: String) -> void:
	var deleted_nest = ''
	match nest:
		"A":
			deleted_nest = nestA
		"B":
			deleted_nest = nestB
		"C":
			deleted_nest = nestC
		"D":
			deleted_nest = nestD
		"E":
			deleted_nest = nestE
			
	remove_child(deleted_nest)
