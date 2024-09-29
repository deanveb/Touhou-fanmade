extends SceneTree

@export var zoom : int

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	#TODO: loop twice to get y, y1 
	#TODO: make path2d point at the center
	
	var file : FileAccess = FileAccess.open("D:/Godot/Touhou(fanmade)/dev_tools/create_path2d_using_graph/output.csv", FileAccess.READ)
	
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
	
	var curves : Array
	
	for coords : Array in arr_coords:
		var curve : Curve2D = Curve2D.new()
		for coord : Dictionary in coords:
			var point : Vector2 = Vector2(float(coord["x"]), float(coord["y"]))
			curve.add_point(point)
		for i in range(coords.size() - 1, -1, -1):
			if len(coords[i]) != 3:
				continue
			var point : Vector2 = Vector2(float(coords[i]["x"]), float(coords[i]["y1"]))
			curve.add_point(point)
		# Sometimes the last point doesn't reach the starting point so it leaves a gap in the circle 
		if len(coords[1]) > 2:
			curve.add_point(Vector2(float(coords[0]["x"]), float(coords[0]["y"])))
		
		curves.append(curve)
	
	var count : int = 0
	for curve : Curve2D in curves:
		var error : Error = ResourceSaver.save(curve, "D:/Godot/Touhou(fanmade)/dev_tools/create_path2d_using_graph/result_pattern/bullet_pattern%s.tres" % count)
		count += 1
		if error:
			print("failed")
		else:
			print("succeed")
	file.close()
	quit()
