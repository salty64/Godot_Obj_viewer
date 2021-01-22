extends Spatial

const ObjParser = preload("res://addons/obj_parser/obj_parser.gd")


func _ready():
	
	pass




func _on_MenuButton_obj_selected(obj_name):

	var path = "../objects/" + obj_name
	$StaticBody/Object.mesh = ObjParser.parse_obj(path)
	
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 

	var aabb 
	aabb=$StaticBody/Object.get_aabb( )

	var obj_center = aabb.size / 2
	$StaticBody.translation = - ( aabb.position + obj_center)





