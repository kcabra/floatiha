extends Area2D

var item = {
	"name": "pebble",
	"icon": load("res://proto1/pebble.png")
}

func interacted():
	self.queue_free()
	return item