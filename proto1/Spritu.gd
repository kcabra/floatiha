extends Area2D

var state = false

func interacted():
	if state == false:
		$AnimationPlayer.play("interact")
		state = true
		return true
	return false