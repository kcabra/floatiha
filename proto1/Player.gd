extends KinematicBody2D

signal item_changed
var current_item = null

func use_item(item_name):
	if current_item and current_item["name"] == item_name:
		current_item = null
		emit_signal("item_changed", null)
		return true
	else:
		return false

func got_item(item):
	emit_signal("item_changed", item)
	current_item = item

signal interacted

func _process(delta):
	## INTERACTION
	# first get subarray of interactables which are overlaping player Area2D
	# then, if any, get the closest one and check it's requirements. if the
	# requirements are met, or if there aren't any, call interact on it.
	# this system assumes that all node in the "interactable" group are Area2Ds
	# with some implementation of a method "interact", which must return true
	# if the player was able to successfully interact with it.
	if Input.is_action_just_pressed("move_down"):
		var nearby_nodes = $Area2D.get_overlapping_areas()
		var selected
		if nearby_nodes.size() == 1:
			selected = nearby_nodes[0]
		elif nearby_nodes.size() >= 1:
			for node in nearby_nodes:
				if (not selected) or ( node.position.distance_to(self.position)
						< selected.position.distance_to(self.position) ):
					selected = node
		if selected:
			if selected.get("requires") and (not use_item(selected.requires)):
					$Speech.say("I should give this spirit a "
							+selected.requires+"...")
			else:
				var ret = selected.interacted()
				if ret:
					emit_signal("interacted")
				if ret is Dictionary:
					got_item(ret)

var move_vec = Vector2.ZERO
var speed = 300
var grounded = false
var jump_timer_button = 1
var jump_timer_ground = 1
const JUMP_TOLERANCE = 0.15

func _physics_process(_delta):
	## HORIZONTAL MOVEMENT
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir = 1
	if Input.is_action_pressed("move_left"):
		dir = -1
	
	if dir == 1:
		move_vec.x = lerp(move_vec.x, speed, 0.5)
	elif dir == -1:
		move_vec.x = lerp(move_vec.x, -speed, 0.5)
	else:
		move_vec.x = lerp(move_vec.x, 0, 0.5)
	
	## VERTICAL MOVEMENT
	if ( $RayCast2D.is_colliding() or
			$RayCast2D2.is_colliding() ):
		grounded = true
	else:
		grounded = false
		
	jump_timer_button += _delta
	jump_timer_ground += _delta
	if grounded:
		jump_timer_ground = 0
	if Input.is_action_just_pressed("move_up"):
		jump_timer_button = 0
	
	if ( jump_timer_button < JUMP_TOLERANCE and
			jump_timer_ground < JUMP_TOLERANCE ):
		move_vec.y = -500
		jump_timer_ground = JUMP_TOLERANCE
		jump_timer_button = JUMP_TOLERANCE
	elif ( Input.is_action_just_released("move_up") and move_vec.y < 0 ):
		move_vec.y /= 4
	elif ( not grounded and move_vec.y < 500 ):
			move_vec.y += 20
	
	## ACTUAL MOVEMENT
	move_and_slide(move_vec, Vector2.UP)