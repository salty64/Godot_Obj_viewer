extends Spatial

const ObjParser = preload("res://addons/obj_parser/obj_parser.gd")

const dirPath = "../objects/"

func resetShape():
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 

func _ready():
	var dir = Directory.new()
	
	if dir.dir_exists(dirPath) and dir.open(dirPath) == OK:
		$Control/ScrollContainer/MenuButton.list_files_in_directory(dir)
	else:
		print("Failed to open directory : " + dirPath)
	
	resetShape()
	pass


func _on_MenuButton_obj_selected(obj_name):
	var path = dirPath + obj_name
	
	$StaticBody/Object.mesh = ObjParser.parse_obj(path)
	
	resetShape()

	var aabb = $StaticBody/Object.get_aabb( )

	var obj_center = aabb.size / 2
	
	$StaticBody.translation = - ( aabb.position + obj_center)
