extends Area2D

export var requires = "pebble"
var state = false

func interacted():
	if state == false:
		$AnimationPlayer.play("interact")
		state = true
		return true
	return false