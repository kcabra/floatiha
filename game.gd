extends Node2D

onready var player = $player
onready var level = $level
onready var song = $song

const SPEED = 100
const JUMP = 500
const GRAV = 5
const OFFSET = 110 # 140
var move_vel = Vector2(SPEED, 0);

var ilhas: Array
var debug_array: Array

func _ready():
	var tween = $CanvasLayer/Tween
	$CanvasLayer/ColorRect.modulate.a = 1
	tween.interpolate_property($CanvasLayer/ColorRect, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	for ilha in level.get_children():
		if "ilha".is_subsequence_of(ilha.name):
			ilhas.append(ilha)

func _process(_delta):
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
	for i in range(ilhas.size()):
		if ilhas[i]:
			var ilha = ilhas[i]
			if song.get_playback_position() > ilha.MUS_POSITION:
				ilha.raise()
				ilhas[i] = null

func _on_song_finished():
	var tween = $CanvasLayer/Tween
	tween.interpolate_property($CanvasLayer/ColorRect, "modulate:a", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	get_tree().change_scene("res://menu.tscn")