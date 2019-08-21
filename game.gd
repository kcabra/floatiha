extends Node2D

onready var player = $player
onready var song = $song

const SPEED = 300
const JUMP = 500
const GRAV = 5
const OFFSET = 110 # 140
var move_vel = Vector2(SPEED, 0);

var ilhas: Array


var debug_array = Array()
func _process(delta):
	if Input.is_action_just_pressed("debug_mark"):
		var pos = song.get_playback_position()
		pos = round(pos * 10) / 10
		debug_array.append(pos)
		print(debug_array)
		
	if !player.is_on_floor():
		move_vel.y += GRAV
	if Input.is_action_just_pressed("game_jump"):
		move_vel.y = -JUMP
	move_vel.x = SPEED
	move_vel = player.move_and_slide(move_vel)
	
	if ilhas.size() > 0 and song.get_playback_position() > ilhas[0]["position"]:
		ilhas.pop_front()["node"].raise()