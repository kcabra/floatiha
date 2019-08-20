extends Area2D

onready var tween = $Tween
onready var sprite = $Sprite
export (float, 0, 2, 0.1) var DURATION = 0.2

func _ready():
	randomize()
	rotation_degrees = rand_range(45, -45)
	sprite.frame = (randi() % 5) + 1 

func raise():
	randomize()
	tween.interpolate_property(self, "position:y", position.y, position.y + rand_range(-32, -64),
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 0,
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
