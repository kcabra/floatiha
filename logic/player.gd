extends KinematicBody2D

onready var sprite = $Sprite
var SPEED = 100

func _ready():
	sprite.playing = true

func _process(delta):
	move_and_slide(Vector2.RIGHT * SPEED)

