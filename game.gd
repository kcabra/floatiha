extends Node2D

onready var player = $player
onready var chao = $level/chao
onready var song = $song
var SPEED = 300
var OFFSET = 0 #140

var ilhas: Array

func _ready():
	var length = song.stream.get_length()
	chao.get_node("Sprite").set_region_rect(Rect2(Vector2(0, 0), Vector2(999999, 46)))
	var ilha_array = [0.02, 0.2, 0.5, 0.7, 0.9, 1.2, 1.8, 2.4, 2.8, 3.3, 3.7, 4, 4.3, 4.5, 4.6, 5, 5.2, 5.4, 5.6, 5.8, 5.9, 6.2, 6.5, 6.7, 6.8, 7.3, 7.8, 8.2, 8.6, 8.9, 9.2, 9.4, 9.7, 9.9, 10.1, 10.3, 10.6, 10.8, 11.1, 11.3, 11.5, 11.6, 12.103401, 12.428481, 12.567801, 12.70712, 13.125079, 13.450159, 13.612699, 13.752018, 14.100317, 14.262857, 14.378957, 14.796916, 14.959455, 15.098776, 15.261315, 15.563174, 15.911474, 16.166893, 16.352654, 17.1, 17.3, 17.5, 17.9, 18.2, 18.4, 18.5, 18.9, 19, 19.1, 19.6, 20, 20.5, 22, 22.1, 22.3, 22.7, 23.1, 23.2, 23.3, 23.7, 23.9, 24, 24.4, 24.5, 25, 25.5, 25.7, 25.9, 26.8, 27, 27.1, 27.5, 27.8, 28, 28.1, 28.5, 28.7, 29.1, 29.6, 30, 31.7, 32.1, 32.2, 32.5, 32.5, 32.5, 32.5]
	var ilha_scene: PackedScene = load("res://ilha.tscn")
	for pos in ilha_array:
		var ilha = ilha_scene.instance()
		ilha.position.x = pos * SPEED + OFFSET
		$level.add_child(ilha)
		ilhas.append({"node": ilha, "position": pos})

var debug_array = Array()
func _process(_delta):
	if Input.is_action_just_pressed("debug_mark"):
		var pos = song.get_playback_position()
		pos = round(pos * 10) / 10
		debug_array.append(pos)
		print(debug_array)
		
	var new_pos = Vector2(SPEED * song.get_playback_position(), player.position.y)
	player.move_and_slide((new_pos - player.position) / _delta)
	print(position - new_pos)
	if ilhas.size() > 0 and song.get_playback_position() > ilhas[0]["position"]:
		ilhas.pop_front()["node"].raise()