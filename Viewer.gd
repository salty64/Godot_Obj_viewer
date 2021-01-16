extends Spatial



func _ready():
	pass
	


func _on_MenuButton_obj_selected(obj_name):
	
	var path = "res://objects/"+obj_name
	
	$StaticBody/Object.mesh = load(path)
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 
#	var mesh_outline = $Object.mesh.create_outline(0.001)
#	print (mesh_outline)
	
	
	var aabb 
	aabb=$StaticBody/Object.get_aabb( )
	print ("hauteur : ",round(aabb.size.y *1000), "mm")
	print ("longeur : ",round(aabb.size.x *1000), "mm")
	print ("largeur : ",round(aabb.size.z *1000), "mm")
	
	
	var obj_center = aabb.size / 2

	$StaticBody.translation = - ( aabb.position + obj_center)
