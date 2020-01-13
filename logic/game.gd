extends Node

onready var song = $song

var ilhas: Array

func _ready():
	song.connect("finished", $fade, "fade_out")
	$fade.fade_in()
	ilhas = $ilhas.get_children()
	ilhas.sort_custom(self, "_sort_island")

func _sort_island(is_this, than_this): # is_this < than_this ?
	return true if is_this.MUS_POS < than_this.MUS_POS else false

func _process(delta):
	if ilhas.size() and ilhas[0].MUS_POS < song.get_playback_position():
		ilhas.pop_front().raise()
