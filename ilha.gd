tool
extends Area2D

onready var tween = $Tween
onready var sprite = $Sprite

enum cores {verde, cristal}
export (cores) var tipo_atual = cores.verde
enum tamanhos {pequena, grande}
export (tamanhos) var tamanho_atual

export (float, 0, 200, 1) var HEIGHT
export (float, 0, 2, 0.1) var DURATION = 0.2
export (float, 0, 300, 0.1) var MUS_POSITION

func _ready():
	var cor
	var tamanho
	match tipo_atual:
		cores.verde:
			cor = "verde"
		cores.cristal:
			cor = "cristal"
	match tamanho_atual:
		tamanhos.grande:
			tamanho = "grande"
		tamanhos.pequena:
			tamanho = "pequena"
	sprite.animation = cor + "-" + tamanho
	randomize()
	position.y = 135
	var count = sprite.frames.get_frame_count(sprite.animation)
	sprite.frame = randi() % count
	rotation_degrees = rand_range(45, -45)

var baseline = -30
var up_range = -130
func raise():
	randomize()
	var raise_amount = HEIGHT if HEIGHT else rand_range(baseline, baseline + up_range)
	tween.interpolate_property(self, "position:y", position.y, raise_amount,
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 0,
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()

func _process(_delta):
	if Engine.editor_hint:
		self.rotation_degrees = 0
		self.position.y = HEIGHT