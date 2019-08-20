extends Area2D

onready var tween = $Tween
onready var sprite = $Sprite
enum cores {verde, amarelo, cristal}
export (cores) var tipo_atual = cores.verde
enum tamanhos {pequena, grande}
export (tamanhos) var tamanho_atual = tamanhos.pequena
export (float, 0, 2, 0.1) var DURATION = 0.2

func _ready():
	var cor
	var tamanho
	match tipo_atual:
		cores.verde:
			cor = "verde"
	match tamanho_atual:
		tamanhos.grande:
			tamanho = "grande"
		tamanhos.pequena:
			tamanho = "pequena"
	sprite.animation = cor + "-" + tamanho
	var count = sprite.frames.get_frame_count(sprite.animation)
	randomize()
	sprite.frame = randi() % count
	match tamanho_atual:
		tamanhos.grande:
			pass
	rotation_degrees = rand_range(45, -45)

func raise():
	randomize()
	tween.interpolate_property(self, "position:y", position.y, position.y + rand_range(-32, -64),
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, 0,
			DURATION, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
