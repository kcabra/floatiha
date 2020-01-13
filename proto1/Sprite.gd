extends AnimatedSprite

onready var player = get_parent()
const MOVE_TOLERANCE = 0.01
var interacting = false

func _process(delta):
	if player.move_vec.x >= MOVE_TOLERANCE:
		self.flip_h = false
	elif player.move_vec.x <= -MOVE_TOLERANCE:
		self.flip_h = true
	
	if not player.is_on_floor():
		self.animation = "jump"
	elif interacting:
		self.animation = "interact"
		yield(self, "animation_finished")
		interacting = false
	elif abs(player.move_vec.x) >= MOVE_TOLERANCE:
		self.animation = "run"
	else:
		self.animation = "still"

func _on_Player_interacted():
	interacting = true