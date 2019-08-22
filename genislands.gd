tool
extends EditorScript

var game
var level

func _run():
	print("running script")
	game = get_scene()
	level = game.get_node("level")
	gen_ilhas()

func get_island_sizes():
	var sizes = Array()
	for ilha in level.get_children():
		if "ilha".is_subsequence_of(ilha.name):
			var info = [ilha.MUS_POSITION, ilha.tamanho_atual]
			sizes.append(info)
	print(var2str(sizes))

func del_all_islands():
	for node in level.get_children():
		if "ilha".is_subsequence_of(node.name):
			node.free()

func gen_ilhas_w_size():
	var sizes = [ [ 17.1, 0 ], [ 20.9, 0 ], [ 21.1, 0 ], [ 21.2, 0 ], [ 23.3, 1 ], [ 24.2, 0 ], [ 25.1, 1 ], [ 25.2, 0 ], [ 25.5, 0 ], [ 26.0, 0 ], [ 29.0, 1 ], [ 29.2, 1 ], [ 32.4, 0 ], [ 32.8, 0 ], [ 33.6, 0 ], [ 34.2, 1 ], [ 34.4, 0 ], [ 35.3, 0 ], [ 35.8, 0 ], [ 36.6, 0 ], [ 36.9, 0 ], [ 37.1, 1 ], [ 37.4, 0 ], [ 38.3, 1 ], [ 38.5, 0 ], [ 38.8, 1 ], [ 39.6, 1 ], [ 39.9, 0 ], [ 40.2, 1 ], [ 40.5, 1 ], [ 41.5, 0 ], [ 42.0, 0 ], [ 44.1, 1 ], [ 44.7, 0 ], [ 45.2, 1 ], [ 45.9, 1 ], [ 46.1, 1 ], [ 46.3, 0 ], [ 46.6, 1 ], [ 47.4, 1 ], [ 47.9, 1 ], [ 48.7, 1 ], [ 48.9, 0 ], [ 49.2, 0 ], [ 49.5, 1 ], [ 50.4, 0 ], [ 51.2, 1 ], [ 52.0, 0 ], [ 53.1, 0 ], [ 53.5, 1 ], [ 55.2, 0 ], [ 55.5, 1 ], [ 55.9, 0 ], [ 57.4, 1 ], [ 57.7, 1 ], [ 58.1, 0 ], [ 59.6, 0 ], [ 59.9, 1 ], [ 60.3, 0 ], [ 61, 0 ], [ 61.3, 1 ], [ 62.4, 0 ] ]
	var ilha_scene: PackedScene = load("res://ilha.tscn")
	randomize()
	for info in sizes:
		var ilha = ilha_scene.instance()
		ilha.position.x = info[0] * game.SPEED + game.OFFSET
		ilha.MUS_POSITION = info[0]
		ilha.tamanho_atual = info[1]
		level.add_child(ilha)
		ilha.set_owner(game)

func gen_ilhas():
	var ilha_scene: PackedScene = load("res://ilha.tscn")
	var ilha_array = [35.4, 35.9, 42.7, 43.2, 43.7, 44.2, 47.5, 47.9, 50.9, 56.3, 56.6, 57.0, 58.5, 58.8, 59.2, 62.4, 62.7, 63, 63.3, 64.4]
	randomize()
	for pos in ilha_array:
		var ilha = ilha_scene.instance()
		ilha.position.x = pos * game.SPEED + game.OFFSET
		ilha.MUS_POSITION = pos
		ilha.tipo_atual = 1
		ilha.tamanho_atual = randi() % 2
		level.add_child(ilha)
		ilha.set_owner(game)