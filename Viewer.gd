extends Spatial



func _ready():
	pass
	


func _on_MenuButton_obj_selected(obj_name):
	
	var path = "res://objects/"+obj_name
	
	$StaticBody/Object.mesh = load(path)
	$StaticBody/CollisionShape.shape = $StaticBody/Object.mesh.create_trimesh_shape() 
	

#	var a = $StaticBody/Object.mesh.surface_get_arrays(0)
#	var m = $StaticBody/Object.mesh.surface_get_material(0)
#	$StaticBody/Object.mesh.surface_remove(0)
#	$StaticBody/Object.mesh.add_surface_from_arrays(1, a)
#	#if there's more than one surface, the surface idx should be the last
#	$StaticBody/Object.mesh.surface_set_material(0, m)

	
	
	var aabb 
	aabb=$StaticBody/Object.get_aabb( )
	print ("hauteur : ",round(aabb.size.y *1000), "mm")
	print ("longeur : ",round(aabb.size.x *1000), "mm")
	print ("largeur : ",round(aabb.size.z *1000), "mm")
	
	
	var obj_center = aabb.size / 2

	$StaticBody.translation = - ( aabb.position + obj_center)
