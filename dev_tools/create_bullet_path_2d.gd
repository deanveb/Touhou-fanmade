extends Node2D

@export var zoom : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TODO: loop twice to get y1, y2 
	#TODO: make path2d point at the center
	
	var file : FileAccess = FileAccess.open("res://dev_tools/get_coord_path2d/output.csv", FileAccess.READ)
	var header : Array = file.get_csv_line()
	var arr_coords : Array
	var temp_coords : Array
	
	while !file.eof_reached():
		var data : Array = file.get_csv_line()
		if data[0] == "":
			arr_coords.append(temp_coords)
			temp_coords = Array()
			continue
		var coord : Dictionary = {}
		for i in range(len(data)):
			coord[header[i]] = data[i]
		temp_coords.append(coord)
	arr_coords.pop_back()
	
	var root_node : Node2D = Node2D.new()
	
	for coords : Array in arr_coords:
		var bullet_pattern : Path2D = Path2D.new() as Path2D
		var curve : Curve2D = Curve2D.new()
		for coord : Dictionary in coords:
			var point : Vector2 = Vector2(float(coord["x"]), float(coord["y1"]))
			curve.add_point(point)
		for i in range(coords.size() - 1, -1, -1):
			if len(coords[i]) != 3:
				continue
			var point : Vector2 = Vector2(float(coords[i]["x"]), float(coords[i]["y2"]))
			curve.add_point(point)
		# Sometimes the last point doesn't reach the starting point so it leaves a gap in the circle 
		curve.add_point(Vector2(float(coords[0]["x"]), float(coords[0]["y1"])))
		bullet_pattern.curve = curve
		bullet_pattern.scale = Vector2(1, 1) * zoom
		
		root_node.add_child(bullet_pattern)
		add_child(bullet_pattern)
	
	var scene : PackedScene = PackedScene.new()
	for child in root_node.get_children():
		child.owner = root_node
	scene.pack(root_node)
	var error : Error = ResourceSaver.save(scene, "res://dev_tools/get_coord_path2d/result_pattern/bullet_pattern.tscn")
	if error:
		print("failed")
	else:
		print("succeed")
