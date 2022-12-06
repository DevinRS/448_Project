extends Node2D

# Function to call both left and right fail effects
func _fail(n=1):
	_failLeft(n)
	_failRight(n)

# Function calls left half of the fail effect
func _failLeft(n=1):
	$Left._fail(n)
	
# Function calls right half of the fail effect
func _failRight(n=1):
	$Right._fail(n)
	
