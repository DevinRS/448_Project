extends Node2D

func updatePointsAndGoal(points, goal):
	$Label.set_text('Points: ' + str(points) + '\n' + 'Goal: ' + goal)
