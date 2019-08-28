tool
extends Node2D

var SPEED = 100
var OFFSET = 140
var GROUND = 270

export (float, 0, 70, 0.1) var MUS_POS = 0.0 setget _update_pos
enum states {FALLEN, RAISED}
export (states) var editor_state
export (float, 0, 1, 0.1) var duration = 0.2
export (int, 10, 250) var height = 150
export (float, -10, 10, 0.5) var init_y = 0
export (float, -45, 45, 0.5) var init_rot = 24

func _update_pos (value):
	MUS_POS = value
	self.position.x = (SPEED * MUS_POS) + OFFSET

func _ready():
	position.y = GROUND + init_y
	rotation_degrees = init_rot

func _process(_delta):
	if Engine.editor_hint:
		match editor_state:
			states.FALLEN:
				position.y = GROUND + init_y
				rotation_degrees = init_rot
			states.RAISED:
				position.y = GROUND - height
				rotation_degrees = 0

func raise():
	var tween = $Tween
	var h_init = GROUND + init_y
	var r_init = init_rot
	var h_fin = GROUND - height
	var r_fin = 0
	
	tween.interpolate_property(self, "position:y", h_init, h_fin,
			duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rotation_degrees", r_init, r_fin,
			duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()