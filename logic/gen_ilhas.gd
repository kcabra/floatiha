extends EditorScript

# each island is a dict on a array
# each dict contains the following info:
# type: qual o tipo da ilha (verde, amarela, cristal)
# size: se a ilha é do tipo pequena ou grande
# (opt) sprite: qual o indice do sprite da ilha
# mus_position: a posição da ilha na música
# duration: quanto tempo leva pra ilha subir
# height: o quanto a ilha sobe
# (opt) init_y: variação em relação ao chao
# (opt) init_rot: rotação inicial

var island_scene
var island_root
var island_array_times
var island_array_nodes

func _run():
	island_scene = preload("res://logic/ilha.tscn")
	island_root = get_scene().get_node("ilhas")

func create_islands():
	var data = ""
	var data_array = str2var(data)
	for entry in data_array:
		var ilha = island_scene.instance()
		ilha.MUS_POS = entry.MUS_POS
		
		if entry.has("height"): ilha.height = entry.height
		else: ilha.height = rand_range(45, 200)
		if entry.has("init_y"): ilha.init_y = entry.init_y
		else: ilha.init_y = rand_range(-10, 10)
		if entry.has("init_rot"): ilha.init_rot = entry.init_rot
		else: ilha.init_rot = rand_range(-45, 45)
		if entry.has("duration"): ilha.duration = entry.duration
		else: ilha.duration = 0.2
		var sprite_number = entry.sprite if entry.has("sprite") else randi() % 
		sprite_name = "%s-%s%d.png" % [entry.type, entry.size, sprite_number]
		ilha.get_node("sprite").texture = load("res://assets/ilhas/"
		
		ilha.add_child(island_root)
		ilha.add_owner(get_scene())